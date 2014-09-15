FactoryGirl.define do
  factory :modified_file do
    patch{build(:git_patch)}
    path{build(:repo_path)}

    initialize_with{new(patch, path)}
  end
end
