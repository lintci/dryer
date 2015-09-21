FactoryGirl.define do
  factory :event, aliases: [:analyze_task_requested_event], class: Hash do
    type 'analyze_task'
    event 'pull_request'
    event_id 'bdb6ec00-5284-11e4-8e22-6dacd62599e2'
    data{attributes_for(:analyze_task).deep_stringify_keys}

    skip_create
    initialize_with do
      {
        'meta' => {
          'event' => event,
          'event_id' => event_id,
          'requested_at' => Time.stamp
        },
        type => data
      }
    end

    factory :lint_task_requested_event do
      type 'lint_task'
      data do
        {
          'id' => 1,
          'type' => 'LintTask',
          'status' => 'scheduled',
          'language' => 'Ruby',
          'tool' => 'RuboCop',
          'build' => {
            'id' => 1,
            'pull_request' => {
              'id' => 1,
              'base_sha' => 'bbf813a806dacf043a592f04a0ed320236caca3a',
              'head_sha' => '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
              'branch' => 'mostly-bad',
              'clone_url' => 'git://github.com/lintci/guinea_pig.git',
              'owner' => 'lintci',
              'repo' => 'guinea_pig'
            }
          },
          'source_files' => [
            {
              'id' => 1,
              'name' => 'bad1.rb',
              'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
              'source_type' => 'Ruby',
              'language' => 'Ruby',
              'linters' => ['RuboCop'],
              'modified_lines' => [1, 2, 3, 4],
              'extension' => '.rb',
              'size' => 31,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'binary' => false,
              'image' => false
            },
            {
              'id' => 2,
              'name' => 'bad2.rb',
              'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
              'source_type' => 'Ruby',
              'language' => 'Ruby',
              'linters' => ['RuboCop'],
              'modified_lines' => [1, 2, 3, 4],
              'extension' => '.rb',
              'size' => 31,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'binary' => false,
              'image' => false
            }
          ]
        }
      end
    end
  end
end
