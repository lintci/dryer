require 'spec_helper'

describe AnalyzeFiles do
  describe '#call' do
    let(:event){build(:analyze_task_requested_event)}
    subject(:service){described_class}

    it 'sends task started and completed events' do
      expect do
        expect do
          service.call(event)
        end.to change{AnalyzeTaskCompletedWorker.jobs.size}.by(1)
      end.to change{TaskStartedWorker.jobs.size}.by(1)

      started_job = TaskStartedWorker.jobs.last
      expect(started_job['args']).to match([
        {
          'task' => {
            'id' => 1,
            'type' => 'AnalyzeTask',
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

      completed_job = AnalyzeTaskCompletedWorker.jobs.last
      expect(completed_job['args']).to match([
        {
          'analysis' => {
            'task_id' => 1,
            'source_files' => [{
              'name' => 'Good.java',
              'sha' => 'ff0d65aad488c95d21821be4f258cb139685ba44',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.coffee',
              'sha' => 'b045a0f5309273ce68e7cb52fc020769cef4a874',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.css',
              'sha' => 'd6b3502a3e5b668fdbcb35c50457cde01b29657e',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.go',
              'sha' => '9516ac5cd5eba1d6b9021468043de3a1ee2b2d9f',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.java',
              'sha' => 'a5e8bc51faa39fb83127ebe1bd9e21b82d438d03',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.js',
              'sha' => 'c6e2cbd471ae9be3ccd9657c4a28161fdf0b5454',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.json',
              'sha' => '1c52b4bb17643f55e3484dba1ec61d95e762f483',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'bad.rb',
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
              'violations' => []
            }, {
              'name' => 'bad.scss',
              'sha' => '035313c6ebfecda56610bbc17a7ac0d26ce25886',
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
              'image' => false,
              'violations' => []
            }, {
              'name' => 'lint.txt',
              'sha' => 'dfea5994965f3bc2e0adaa57922f30b11c5bcf13',
              'language' => 'Unknown',
              'linters' => ['Unknown'],
              'modified_lines' => [1],
              'source_type' => 'Unknown',
              'size' => 5,
              'extension' => '.txt',
              'binary' => false,
              'generated' => false,
              'vendored' => false,
              'documentation' => false,
              'image' => false,
              'violations' => []
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
