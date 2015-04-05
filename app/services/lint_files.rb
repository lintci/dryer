require 'command_service'

class LintFiles < TaskService
  def initialize(data)
    @task = LintTask.new(data['lint_task'])
    @container = LintTrap::Container::Docker.new('lintci/lint_trap')
    @linter =  LintTrap::Linter.find(task.tool)
  end

  def call
    start_task

    clone_repository do |repo|
      linting = lint(repo) do |file_lint|
        file_linted(file_lint)
      end

      finish_task(linting)
    end
  end

protected

  attr_reader :container, :linter

private

  def lint(repo)
    linter.run(repo.files)
  end

  def file_linted(file_lint)

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
