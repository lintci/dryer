class ClassifyTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer, backtrace: true

  def perform(data)
    ClassifyChanges.call(data)
  end
end
