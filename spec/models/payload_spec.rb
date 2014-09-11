require 'spec_helper'

describe Payload do
  let(:data) do
    json_fixture_file('github/pull_request_opened_payload.json')
  end
  subject(:payload){Payload.new(data)}

  its(:pull_request?){is_expected.to be_truthy}
  its(:pull_request){is_expected.to eq(PullRequest.new(data['pull_request']))}
end
