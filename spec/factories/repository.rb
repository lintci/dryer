FactoryGirl.define do
  factory :repository do
    repos_dir
    task

    skip_create
    initialize_with do
      Repository.clone(repos_dir, task)
    end
  end
end
