FactoryGirl.define do
  factory :git_patch, class: Rugged::Patch do
    diff{build(:git_diff)}

    initialize_with do
      diff.patches.first
    end
  end
end
