require 'spec_helper'

describe PullRequest do
  subject(:pull_request){build(:pull_request)}

  its(:id){is_expected.to eq(1)}
  its(:base_sha){is_expected.to eq('bbf813a806dacf043a592f04a0ed320236caca3a')}
  its(:head_sha){is_expected.to eq('6dbc62fe88432b6f9489a3d9f00dddf955a44c4e')}
  its(:branch){is_expected.to eq('mostly-bad')}
  its(:clone_url){is_expected.to eq('git://github.com/lintci/guinea_pig.git')}
  its(:owner){is_expected.to eq('lintci')}
  its(:repo){is_expected.to eq('guinea_pig')}
  its(:slug){is_expected.to eq('lintci/guinea_pig/6dbc62fe88432b6f9489a3d9f00dddf955a44c4e')}
  its(:inspect){is_expected.to eq('<PullRequest:lintci/guinea_pig (bbf813a...6dbc62f)>')}
end
