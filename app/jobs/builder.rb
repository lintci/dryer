# Determines type of build from payload and executes it
class BuilderJob < ActiveJob::Base
  queue_as :build

  def perform(build_id, payload_data)
    payload = Payload.new(payload_data)

    PullRequestBuild.new(build_id, payload.pull_request).run if payload.pull_request?
  end
end
