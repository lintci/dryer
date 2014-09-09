FactoryGirl.define do
  factory :git_diff, class: Rugged::Diff do
    repo{build(:git_repo, :bad_ruby_file)}

    initialize_with do
      repo.diff('HEAD~1', 'HEAD')
    end
  end
end
