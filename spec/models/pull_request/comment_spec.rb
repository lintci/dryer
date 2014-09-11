require 'spec_helper'

describe PullRequest::Comment do
  describe '#add' do
    let(:pull_request){build(:pull_request)}
    subject(:comment){PullRequest::Comment.new(pull_request)}

    it 'successfully adds a comment to the pull request', vcr: {match_requests_on: [:method, :host, :path]} do
      result = comment.add('Good.java', '3', 'Nice comment.')
      expect(result.path).to eq('Good.java')
      expect(result.body).to eq('Nice comment.')
      expect(result.position).to eq(3)
      expect(result.created_at).to be_a(Time)
    end
  end
end
