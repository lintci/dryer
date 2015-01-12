FactoryGirl.define do
  factory :modified_file do
    workdir
    name 'bad.rb'
    lines [1, 2, 3]

    skip_create
    initialize_with{new(workdir, name, lines)}
  end
end
