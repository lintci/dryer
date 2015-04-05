FactoryGirl.define do
  factory :event, aliases: [:classify_task_requested_event], class: Hash do
    event 'pull_request'
    event_id 'bdb6ec00-5284-11e4-8e22-6dacd62599e2'
    data{attributes_for(:classify_task).deep_stringify_keys}

    skip_create
    initialize_with do
      {
        'meta' => {
          'event' => event,
          'event_id' => event_id,
          'requested_at' => Time.stamp
        },
        'classify_task' => data
      }
    end

    factory :lint_task_requested_event do
      data{attributes_for(:lint_task).deep_stringify_keys}
    end
  end
end
