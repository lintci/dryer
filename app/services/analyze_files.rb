require 'jsonapi_resource'

# Lints a pull request
class AnalyzeFiles < TaskService
  def initialize(data)
    task_data, @meta = JSONAPIResource.new(data).deserialize

    @task = AnalyzeTask.new(task_data)
    meta[:started_at] = Time.stamp
  end

  def call
    start_task

    clone_repository do |repo, _clone_started_at, _clone_finished_at|
      source_files = repo.source_files(task.base_sha, task.head_sha)

      complete_task(source_files)
    end
  end

protected

  attr_reader :meta

private

  def serializer
    Msg::V1::AnalyzeTaskSerializer
  end

  def complete_task(source_files)
    json = serialize_task(
      task.with(source_files: source_files),
      meta: meta.merge!(task_finished_at: Time.stamp),
      include: :source_files
    )

    AnalyzeTaskCompletedWorker.perform_async(json)
  end
end
