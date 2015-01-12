FactoryGirl.define do
  factory :base_sha, class: String do
    skip_create
    initialize_with{'bbf813a806dacf043a592f04a0ed320236caca3a'}
  end

  factory :head_sha, class: String do
    skip_create
    initialize_with{'6dbc62fe88432b6f9489a3d9f00dddf955a44c4e'}
  end
end
