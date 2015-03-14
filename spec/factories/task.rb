FactoryGirl.define do
  factory :task, aliases: [:classify_task] do
    id 1
    type 'ClassifyTask'
    status 'queued'
    language 'All'
    tool 'Linguist'
    build{attributes_for(:build).deep_stringify_keys}

    skip_create
    initialize_with do
      Task.new(
        'id' => id,
        'type' => type,
        'status' => status,
        'language' => language,
        'tool' => tool,
        'build' => build
      )
    end

    trait(:lint_task) do
      type 'LintTask'
      language 'Ruby'
      tool 'RuboCop'
    end
  end
end
