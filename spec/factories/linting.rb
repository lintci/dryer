FactoryGirl.define do
  factory :linting do
    task_id 1
    clean false

    skip_create
    initialize_with{new(attributes)}
  end
end
