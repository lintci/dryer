FactoryGirl.define do
  factory :git_diff, class: Rugged::Diff do
    repo{build(:git_repo, :bad_ruby_file)}
    base 'HEAD~1'
    head 'HEAD'

    initialize_with do
      repo.diff(base, head)
    end
  end
end
