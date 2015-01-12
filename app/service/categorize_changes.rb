require 'command_service'

# Lints a pull request
class CategorizeChanges < CommandService
  def initialize(data)
    @task = Task.new(data)
  end

  def call
    clone_repository do |repo|
      files = repo.modified_files(pull_request)

      run_linters(files)
    end
  end

protected

  attr_reader :task

private

  def run_linters(files)
    workers = files.grouped_by_linter.map do |linter, modified_files|
      LintWorker.new(pull_request, linter, modified_files, Subscription.new)
    end

    workers.all?(&:value)
  end

  def clone_repository
    Repository.clone(repositories_path, task, &Proc.new)
  end

  def repositories_path
    Rails.root.join('tmp')
  end
end
