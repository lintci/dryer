FactoryGirl.define do
  factory :git_hunk, class: Rugged::Diff::Hunk do
    patch{build(:git_patch)}

    initialize_with do
      patch.hunks.first
    end
  end
end
