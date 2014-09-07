FactoryGirl.define do
  factory :linted_file do
    file_name 'bad.rb'

    initialize_with{new(file_name)}
  end
end
