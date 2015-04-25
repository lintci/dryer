# Sent from laundromat. Informs dryer to analyze files.
class AnalyzeTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(data)
    AnalyzeFiles.call(data)
  end
end
