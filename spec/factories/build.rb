FactoryGirl.define do
  factory :build do
    id 1
    pull_request{attributes_for(:pull_request)}

    skip_create
    initialize_with do
      Build.new(
        'id' => id,
        'pull_request' => pull_request.deep_stringify_keys
      )
    end
  end
end
