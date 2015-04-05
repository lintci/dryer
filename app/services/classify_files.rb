require 'command_service'

# Lints a pull request
class ClassifyFiles < TaskService
  def initialize(data)
    super(data)

    @task = ClassifyTask.new(data['classify_task'])
  end

  def call
    start_task

    clone_repository do |repo|
      files = repo.source_files(task.base_sha, task.head_sha)
      classification = classify(files)

      complete_task(classification)
    end
  end

private

  def classify(files)
    Classification.new(task.id, files)
  end

  def complete_task(classification)
    serializer = ClassificationSerializer.new(
      classification,
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at,
        finished_at: Time.stamp
      }
    )

    ClassifyTaskCompletedWorker.perform_async(serializer.as_json)
  end
end
