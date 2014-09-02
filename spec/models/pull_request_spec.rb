require 'spec_helper'
require 'models/pull_request'

describe PullRequest do
  let(:data) do
    json_fixture_file('github/pull_request_opened_payload.json')['pull_request']
  end
  subject(:payload){PullRequest.new(data)}

  its(:base_sha){is_expected.to eq('bbf813a806dacf043a592f04a0ed320236caca3a')}
  its(:head_sha){is_expected.to eq('6dbc62fe88432b6f9489a3d9f00dddf955a44c4e')}
  its(:branch){is_expected.to eq('mostly-bad')}
  its(:clone_url){is_expected.to eq('git://github.com/lintci/guinea_pig.git')}
  its(:owner){is_expected.to eq('lintci')}
  its(:repo){is_expected.to eq('guinea_pig')}
  its(:slug){is_expected.to eq('lintci/guinea_pig/mostly-bad')}
  its(:inspect){is_expected.to eq('<PullRequest:lintci/guinea_pig/mostly-bad (bbf813a...6dbc62f)>')}
end
