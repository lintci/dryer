require 'securerandom'

FactoryGirl.define do
  factory :task, aliases: [:analyze_task], class: AnalyzeTask do
    id{SecureRandom.uuid}
    type 'AnalyzeTask'
    status 'started'
    language 'All'
    tool 'Linguist'
    build{attributes_for(:build).deep_stringify_keys}

    skip_create
    initialize_with{new(attributes)}

    factory :lint_task, traits: [:with_source_files], class: LintTask do
      type 'LintTask'
      language 'Ruby'
      tool 'RuboCop'
    end

    trait :with_source_files do
      source_files do
        [
          attributes_for(:source_file, name: 'bad1.rb').deep_stringify_keys,
          attributes_for(:source_file, name: 'bad2.rb').deep_stringify_keys
        ]
      end
    end
  end
end
