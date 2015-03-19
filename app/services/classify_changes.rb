require 'command_service'

# Lints a pull request
class ClassifyChanges < CommandService
  def initialize(data)
    @event = data['meta']['event']
    @event_id = data['meta']['event_id']
    @task = Task.new(data['task'])
    @started_at = timestamp
  end

  def call
    start_task

    clone_repository do |repo|
      files = repo.modified_files(task.base_sha, task.head_sha)
      classification = classify(files)

      complete_task(classification)
    end
  end

protected

  attr_reader :event, :event_id, :task, :started_at

private

  def classify(files)
    Classification.new(task.id, files)
  end

  def start_task
    serializer = TaskSerializer.new(
      task,
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at
      }
    )

    TaskStartedWorker.perform_async(serializer.as_json)
  end

  def complete_task(classification)
    serializer = ClassificationSerializer.new(
      classification,
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at,
        finished_at: timestamp
      }
    )

    ClassifyTaskCompletedWorker.perform_async(serializer.as_json)
  end

  def clone_repository
    Repository.clone(repositories_path, task, &Proc.new)
  end

  def repositories_path
    Rails.root.join('tmp')
  end

  def timestamp
    Time.now.utc.iso8601
  end
end
