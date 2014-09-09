FactoryGirl.define do
  factory :git_repo, class: Rugged::Repository do
    path File.expand_path('../../../tmp/repos', __FILE__)
    name 'test'

    initialize_with do
      Rugged::Repository.init_at(File.join(path, name)).tap do |repo|
        build(:git_commit, repo: repo)
      end
    end

    trait :bad_ruby_file do
      after(:build) do |repo|
        build(:git_commit, :bad_ruby_file, repo: repo)
      end
    end
  end
end
