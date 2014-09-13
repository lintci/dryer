FactoryGirl.define do
  factory :linted_file do
    file_name 'bad.rb'

    initialize_with do
      new(file_name)
    end
  end
end
