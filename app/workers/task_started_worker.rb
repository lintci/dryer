class TaskStartedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(_data)
  end
end
