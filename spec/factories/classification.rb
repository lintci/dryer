FactoryGirl.define do
  factory :classification do
    task_id 1
    modified_files []

    skip_create
    initialize_with do
      Classification.new(task_id, modified_files)
    end

    trait :with_modified_files do
      modified_files do
        [
          build(:coffeescript_modified_file),
          build(:javascript_modified_file),
          build(:ruby_modified_file)
        ]
      end
    end
  end
end
