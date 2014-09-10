FactoryGirl.define do
  factory :pull_request do
    payload{build(:pull_request_opened_payload)}

    initialize_with{payload.pull_request}
  end
end
