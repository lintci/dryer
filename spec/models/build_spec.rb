require 'spec_helper'

describe Build do
  subject(:build){FactoryGirl.build(:build)}

  its(:id){is_expected.to eq(1)}
  its(:pull_request){is_expected.to be_a(PullRequest)}
  its(:inspect){is_expected.to eq('<Build: 1>')}
end
