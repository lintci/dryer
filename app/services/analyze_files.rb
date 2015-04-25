# Lints a pull request
class AnalyzeFiles < TaskService
  def initialize(data)
    super(data)

    @task = AnalyzeTask.new(data['analyze_task'])
  end

  def call
    start_task

    clone_repository do |repo|
      files = repo.source_files(task.base_sha, task.head_sha)
      analysis = analyze(files)

      complete_task(analysis)
    end
  end

private

  def analyze(files)
    Analysis.new(task_id: task.id, source_files: files)
  end

  def complete_task(analysis)
    serializer = AnalysisSerializer.new(
      analysis,
      meta: {
        event: event,
        event_id: event_id,
        started_at: started_at,
        finished_at: Time.stamp
      }
    )

    AnalyzeTaskCompletedWorker.perform_async(serializer.as_json)
  end
end
