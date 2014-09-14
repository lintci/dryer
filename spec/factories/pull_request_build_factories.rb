FactoryGirl.define do
  factory :pull_request_build do
    id 1
    pull_request{build(:pull_request)}

    initialize_with{new(id, pull_request)}
  end
end
