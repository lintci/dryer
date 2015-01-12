FactoryGirl.define do
  factory :task do
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

    trait(:classify) do
      type 'ClassifyTask'
      language 'All'
      tool 'Linguist'
    end

    trait(:lint) do
      type 'LintTask'
      language 'Ruby'
      tool 'RuboCop'
    end
  end
end
