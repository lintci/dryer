class CategorizationTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer, backtrace: true

  def perform(data)
    CategorizeChanges.call(data)
  end
end
