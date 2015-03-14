FactoryGirl.define do
  factory :event, aliases: [:categorization_task_requested_event], class: Hash do
    event 'pull_request'
    event_id 'bdb6ec00-5284-11e4-8e22-6dacd62599e2'
    data{attributes_for(:classify_task).deep_stringify_keys}

    skip_create
    initialize_with do
      {
        'meta' => {
          'event' => event,
          'event_id' => event_id
        },
        'task' => data
      }
    end
  end
end
