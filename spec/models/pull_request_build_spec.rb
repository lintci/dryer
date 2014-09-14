require 'spec_helper'

describe PullRequestBuild do
  subject(:pull_request_build){build(:pull_request_build)}

  its(:inspect){is_expected.to eq('<Build: #1 lintci/guinea_pig/mostly-bad>')}
end
