require 'spec_helper'

describe Build do
  subject(:build){FactoryGirl.build(:build)}

  its(:id){is_expected.to eq(1)}
  its(:pull_request){is_expected.to be_a(PullRequest)}
  its(:slug){is_expected.to eq('lintci/guinea_pig/6dbc62fe88432b6f9489a3d9f00dddf955a44c4e/1')}
  its(:inspect){is_expected.to eq('<Build: 1>')}
end
