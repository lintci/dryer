FactoryGirl.define do
  factory :repos_path, class: String do
    initialize_with{File.expand_path('../../../tmp/repos', __FILE__)}
  end
end
