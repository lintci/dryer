# Takes a lint task, executing the specified linter on all the files for that task. Notifies
# laundromat of the results.
class LintFiles < TaskService
  def initialize(data)
    task_data, @meta = JSONAPIResource.new(data).deserialize

    @task = LintTask.new(task_data)
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

protected

  attr_reader :meta

private

  def serializer
    Msg::V1::LintTaskSerializer
  end

  def lint(repo)
    linter = setup_linter(repo)

    linter.lint({}) do |source_file, started_at, finished_at|
      yield source_file, started_at, finished_at
    end
  end

  def setup_linter(repo)
    linter = Linter.new(task.tool, repo.workdir, task.source_files)
    image, setup_started_at, setup_finished_at = linter.setup

    meta.merge!(
      docker_image: image,
      setup_started_at: setup_started_at.stamp,
      setup_finished_at: setup_finished_at.stamp
    )

    linter
  end

  def file_linted(source_file, started_at, finished_at)
    json = serialize_task(
      task.with(source_files: [source_file]),
      meta: meta.merge(started_at: started_at.stamp, finished_at: finished_at.stamp),
      include: 'source_files.violations',
      serializer: Msg::V1::SourceFileSerializer
    )

    FileLintedWorker.perform_async(json)
  end

  def finish_task(clean)
    json = serialize_task(task, meta: meta.merge!(task_finished_at: Time.stamp, clean: clean))

    LintTaskCompletedWorker.perform_async(json)
  end
end
