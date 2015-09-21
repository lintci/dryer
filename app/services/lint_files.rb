# Takes a lint task, executing the specified linter on all the files for that task. Notifies
# laundromat of the results.
class LintFiles < TaskService
  def initialize(data)
    super(data)
    @task = LintTask.new(data['lint_task'])
  end

  def call
    start_task

    clone_repository do |repo, _clone_started_at, _clone_finished_at|
      clean = lint(repo) do |source_file, started_at, finished_at|
        file_linted(source_file, started_at, finished_at)
      end

      finish_task(clean)
    end
  end

private

  def lint(repo)
    linter = Linter.new(task.tool, repo.workdir, task.source_files)
    _image, _setup_started_at, _setup_finished_at = linter.setup

    linter.lint({}) do |source_file, started_at, finished_at|
      yield source_file, started_at, finished_at
    end
  end

  def file_linted(source_file, started_at, finished_at)
    serializer = SourceFileSerializer.new(
      source_file,
      meta: {
        event: event,
        event_id: event_id,
        task_id: task.id,
        started_at: started_at.stamp,
        finished_at: finished_at.stamp
      }
    )

    FileLintedWorker.perform_async(serializer.as_json)
  end

  def finish_task(clean)
    serializer = LintingSerializer.new(
      linting(clean),
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at,
        finished_at: Time.stamp
      }
    )

    LintTaskCompletedWorker.perform_async(serializer.as_json)
  end

  def linting(clean)
    Linting.new(task_id: task.id, clean: clean)
  end
end
