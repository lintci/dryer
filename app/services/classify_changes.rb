require 'command_service'

# Lints a pull request
class ClassifyChanges < CommandService
  def initialize(data)
    @event_id = data['meta']['event_id']
    @task = Task.new(data['task'])
  end

  def call
    clone_repository do |repo|
      files = repo.modified_files(task.base_sha, task.head_sha)

      classify(files)
    end
  end

protected

  attr_reader :event_id, :task

private

  def classify(files)
    classification = Classification.new(task.id, files)
    serializer = ClassificationSerializer.new(classification)
    ClassifyTaskCompletedWorker.perform_async(serializer.as_json(meta: {event_id: event_id}))
  end

  def clone_repository
    Repository.clone(repositories_path, task, &Proc.new)
  end

  def repositories_path
    Rails.root.join('tmp')
  end
end
