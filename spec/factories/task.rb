FactoryGirl.define do
  factory :task, aliases: [:analyze_task] do
    id 1
    type 'AnalyzeTask'
    status 'queued'
    language 'All'
    tool 'Linguist'
    build{attributes_for(:build).deep_stringify_keys}

    skip_create
    initialize_with{new(attributes)}

    factory :lint_task do
      type 'LintTask'
      language 'Ruby'
      tool 'RuboCop'
      source_files do
        [
          attributes_for(:source_file, name: 'bad1.rb').deep_stringify_keys,
          attributes_for(:source_file, name: 'bad2.rb').deep_stringify_keys
        ]
      end
    end
  end
end
