class ClassifyTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(data)
    ClassifyFiles.call(data)
  end
end
