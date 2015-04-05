FactoryGirl.define do
  factory :classification do
    task_id 1
    source_files []

    skip_create
    initialize_with do
      Classification.new(task_id, source_files)
    end

    trait :with_source_files do
      source_files do
        [
          build(:coffeescript_source_file),
          build(:javascript_source_file),
          build(:ruby_source_file)
        ]
      end
    end
  end
end
