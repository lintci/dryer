FactoryGirl.define do
  factory :pull_request_comment, class: PullRequest::Comment do
    pull_request{build(:pull_request)}
  end
end
