FactoryGirl.define do
  factory :repo_path, class: String do
    repos_path{build(:repos_path)}

    initialize_with{File.join(repos_path, 'test')}
  end
end
