# Sent from laundromat. Informs dryer to lint files.
class LintTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(data)
    LintFiles.call(data)
  end
end
