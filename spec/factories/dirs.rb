FactoryGirl.define do
  factory :repos_dir, class: String do
    skip_create
    initialize_with{File.expand_path('../../../tmp/repos', __FILE__)}
  end

  factory :workdir, class: String do
    repos_dir
    task

    skip_create
    initialize_with{File.join(repos_dir, task.slug) + '/'}
  end

  factory :fixtures_dir, class: String do
    skip_create
    initialize_with{File.expand_path('../../fixtures', __FILE__)}
  end
end
