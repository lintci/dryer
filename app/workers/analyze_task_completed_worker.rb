# Notifies laundromat that the analyze task is complete
class AnalyzeTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(_data)
  end
end
