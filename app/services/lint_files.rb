require 'command_service'

class LintFiles < TaskService
  def initialize(data)
    @task = LintTask.new(data['lint_task'])
  end

  def call
    start_task

    clone_repository do |repo|
      linting = lint(repo) do |source_file, started_at, finished_at|
        file_linted(source_file, started_at, finished_at)
      end

      finish_task(linting)
    end
  end

protected

  attr_reader :tool, :container, :linter

private

  def lint(repo)
    linter = Linter.new(task.tool, repo.workdir, task.source_files)
    linter.run({}) do |source_file, started_at, finished_at|
      yield source_file, started_at, finished_at
    end
  end

  def file_linted(source_file, started_at, finished_at)
    serializer = SourceFileSerializer.new(
      source_file,
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at,
        finished_at: finished_at
      }
    )

    FileLintedWorker.perform_async(serializer.as_json)
  end

  def finish_task(linting)
    serializer = LintingSerializer.new(
      linting,
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at,
        finished_at: Time.stamp
      }
    )

    LintTaskCompletedWorker.perform_async(serializer.as_json)
  end
end
