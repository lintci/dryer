FactoryGirl.define do
  factory :diff, class: Repository::Diff do
    repository
    base_sha
    head_sha

    skip_create
    initialize_with do
      repository.diff(base_sha, head_sha)
    end
  end
end
