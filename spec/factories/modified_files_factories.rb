FactoryGirl.define do
  factory :modified_files do
    diff{build(:git_diff)}
    path{build(:repo_path)}

    initialize_with{new(diff, path)}
  end
end
