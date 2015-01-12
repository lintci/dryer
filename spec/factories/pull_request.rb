FactoryGirl.define do
  factory :pull_request do
    id 1
    base_sha{build(:base_sha)}
    head_sha{build(:head_sha)}
    branch 'mostly-bad'
    clone_url 'git://github.com/lintci/guinea_pig.git'
    owner 'lintci'
    repo 'guinea_pig'

    skip_create
    initialize_with do
      PullRequest.new(
        'id' => id,
        'base_sha' => base_sha,
        'head_sha' => head_sha,
        'branch' => branch,
        'clone_url' => clone_url,
        'owner' => owner,
        'repo' => repo
      )
    end
  end
end
