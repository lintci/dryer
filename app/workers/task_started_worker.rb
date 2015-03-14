class TaskStartedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
  end
end
