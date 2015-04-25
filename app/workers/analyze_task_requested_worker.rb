class AnalyzeTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(data)
    AnalyzeFiles.call(data)
  end
end
