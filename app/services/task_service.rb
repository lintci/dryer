# Provides commen behavior for task execution
class TaskService
  class << self
    def call(*args)
      new(*args).call
    end
  end

  def initialize(data)
    @event = data['meta']['event']
    @event_id = data['meta']['event_id']
    @started_at = Time.stamp
  end

protected

  attr_reader :event, :event_id, :task, :started_at

private

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

  def clone_repository
    repositories_path = Rails.root.join('tmp')

    Repository.clone(repositories_path, task, &Proc.new)
  end
end
