# Provides commen behavior for task execution
class TaskService
  class << self
    def call(*args)
      new(*args).call
    end
  end

protected

  attr_reader :event, :event_id, :task, :started_at

private

  def serialize_task(task, options = {})
    serialize(task, options.merge(serializer: serializer))
  end

  def serialize(object, options = {})
    ActiveModel::SerializableResource.new(object, options).as_json
  end

  def start_task
    json = serialize_task(task, meta: meta.merge!(task_started_at: Time.stamp))

    TaskStartedWorker.perform_async(json)
  end

  def clone_repository
    repositories_path = Rails.root.join('tmp/repos')

    Repository.clone(repositories_path, task, &Proc.new)
  end
end
