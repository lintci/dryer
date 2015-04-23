# Notifies laundromat about a single files violations
class FileLintedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(_data)
  end
end
