class BuilderJob < ActiveJob::Base
  queue_as :build

  def perform(build_id, payload)
    Build.new(build_id, payload).run
  end
end
