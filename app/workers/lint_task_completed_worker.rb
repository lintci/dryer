# Notifies laundromat that the lint task is complete
class LintTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(_data)
  end
end
