require 'spec_helper'

describe LintFiles do
  describe '#call' do
    let(:event){build(:lint_task_requested_event)}
    let(:violation_attributes){attributes_for(:violation)}
    subject(:service){described_class}

    it 'sends task started, file linted, and task finished events' do
      expect_linter = expect_any_instance_of(LintTrap::Linter::RuboCop)
      expect_linter.to receive(:lint).and_yield(
        violation_attributes.merge(file: 'bad1.rb')
      ).and_yield(
        violation_attributes.merge(file: 'bad2.rb')
      )

      expect do
        expect do
          expect do
            subject.call(event)
          end.to change{LintTaskCompletedWorker.jobs.size}.by(1)
        end.to change{FileLintedWorker.jobs.size}.by(2)
      end.to change{TaskStartedWorker.jobs.size}.by(1)

      started_job = TaskStartedWorker.jobs.last
      expect(started_job['args']).to match([
        {
          'task' => {
            'id' => 1,
            'type' => 'LintTask',
            'language' => 'Ruby',
            'tool' => 'RuboCop'
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'started_at' => be_timestamp
          }
        }
      ])

      first_linted_file_job = FileLintedWorker.jobs.first
      expect(first_linted_file_job['args']).to match([
        {
          'source_file' => {
            'id' => 1,
            'name' => 'bad1.rb',
            'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
            'language' => 'Ruby',
            'linters' => ['RuboCop'],
            'modified_lines' => [1, 2, 3, 4],
            'source_type' => 'Ruby',
            'size' => 31,
            'extension' => '.rb',
            'binary' => false,
            'generated' => false,
            'vendored' => false,
            'documentation' => false,
            'image' => false,
            'violations' => [
              {
                'line' => 2,
                'column' => 7,
                'length' => 4,
                'rule' => 'Style/MethodName',
                'severity' => 'convention',
                'message' => 'Use snake_case for methods.'
              }
            ]
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'task_id' => 1,
            'started_at' => be_timestamp,
            'finished_at' => be_timestamp
          }
        }
      ])

      second_linted_file_job = FileLintedWorker.jobs.last
      expect(second_linted_file_job['args']).to match([
        {
          'source_file' => {
            'id' => 2,
            'name' => 'bad2.rb',
            'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
            'language' => 'Ruby',
            'linters' => ['RuboCop'],
            'modified_lines' => [1, 2, 3, 4],
            'source_type' => 'Ruby',
            'size' => 31,
            'extension' => '.rb',
            'binary' => false,
            'generated' => false,
            'vendored' => false,
            'documentation' => false,
            'image' => false,
            'violations' => [
              {
                'line' => 2,
                'column' => 7,
                'length' => 4,
                'rule' => 'Style/MethodName',
                'severity' => 'convention',
                'message' => 'Use snake_case for methods.'
              }
            ]
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'task_id' => 1,
            'started_at' => be_timestamp,
            'finished_at' => be_timestamp
          }
        }
      ])

      completed_job = LintTaskCompletedWorker.jobs.last
      expect(completed_job['args']).to match([
        {
          'linting' => {
            'task_id' => 1,
            'clean' => false
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'started_at' => be_timestamp,
            'finished_at' => be_timestamp
          }
        }
      ])
    end
  end
end
