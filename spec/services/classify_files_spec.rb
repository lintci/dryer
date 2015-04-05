require 'spec_helper'

describe ClassifyFiles do
  describe '#call' do
    let(:event){build(:classify_task_requested_event)}
    subject(:service){described_class.new(event)}

    it 'sends task started and completed events' do
      expect do
        expect do
          service.call
        end.to change{ClassifyTaskCompletedWorker.jobs.size}.by(1)
      end.to change{TaskStartedWorker.jobs.size}.by(1)

      started_job = TaskStartedWorker.jobs.last
      expect(started_job['args']).to match([
        {
          'task' => {
            'id' => 1,
            'type' => 'ClassifyTask',
            'language' => 'All',
            'tool' => 'Linguist'
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'started_at' => be_timestamp
          }
        }
      ])

      completed_job = ClassifyTaskCompletedWorker.jobs.last
      expect(completed_job['args']).to match([
        {
          'classification' => {
            'task_id' => 1,
            'source_files' => [{
              'name' => 'Good.java',
              'language' => 'Java',
              'linters' => ['CheckStyle'],
              'modified_lines' => [1, 2, 3, 4, 5, 6],
              'source_type' => 'Java',
              'size' => 80,
              'extension' => '.java',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.coffee',
              'language' => 'CoffeeScript',
              'linters' => ['CoffeeLint'],
              'modified_lines' => [1],
              'source_type' => 'CoffeeScript',
              'size' => 11,
              'extension' => '.coffee',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.css',
              'language' => 'CSS',
              'linters' => ['CSSLint'],
              'modified_lines' => [1, 2, 3, 4],
              'source_type' => 'CSS',
              'size' => 58,
              'extension' => '.css',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.go',
              'language' => 'Go',
              'linters' => ['GoLint'],
              'modified_lines' => [1, 2, 3, 4, 5, 6, 7],
              'source_type' => 'Go',
              'size' => 75,
              'extension' => '.go',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.java',
              'language' => 'Java',
              'linters' => ['CheckStyle'],
              'modified_lines' => [1, 2, 3],
              'source_type' => 'Java',
              'size' => 22,
              'extension' => '.java',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.js',
              'language' => 'JavaScript',
              'linters' => ['JSHint'],
              'modified_lines' => [1, 2, 3],
              'source_type' => 'JavaScript',
              'size' => 40,
              'extension' => '.js',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.json',
              'language' => 'JSON',
              'linters' => ['JSONLint'],
              'modified_lines' => [1, 2, 3, 4],
              'source_type' => 'JSON',
              'size' => 30,
              'extension' => '.json',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'bad.rb',
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
              'image' => false
            }, {
              'name' => 'bad.scss',
              'language' => 'SCSS',
              'linters' => ['SCSSLint'],
              'modified_lines' => [1, 2, 3],
              'source_type' => 'SCSS',
              'size' => 22,
              'extension' => '.scss',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }, {
              'name' => 'lint.txt',
              'language' => 'Text',
              'linters' => ['Unknown'],
              'modified_lines' => [1],
              'source_type' => 'Text',
              'size' => 5,
              'extension' => '.txt',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false
            }]
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
