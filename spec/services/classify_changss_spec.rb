require 'spec_helper'

describe ClassifyChanges do
  describe '#call' do
    let(:event){build(:categorization_task_requested_event)}
    subject(:service){ClassifyChanges.new(event)}

    it 'sends task started and completed events' do
      expect do
        expect do
          service.call
        end.to change{ClassifyTaskCompletedWorker.jobs.size}.by(1)
      end.to change{TaskStartedWorker.jobs.size}.by(1)

      iso8601_regex = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z\z/

      started_job = TaskStartedWorker.jobs.last
      expect(started_job['args']).to match([{
        "task" => {
          "id" => 1,
          "type" => "ClassifyTask",
          "language" => "All",
          "tool" => "Linguist"
        },
        "meta" => {
          "event" => "pull_request",
          "event_id" => "bdb6ec00-5284-11e4-8e22-6dacd62599e2",
          "started_at" => iso8601_regex
        }
      }])

      completed_job = ClassifyTaskCompletedWorker.jobs.last
      expect(completed_job['args']).to match([{
        "classification" => {
          "task_id" => 1,
          "groups" => [
            {
              "linter" => "CheckStyle",
              "language" => "Java",
              "modified_files" => [{"name" => "Good.java", "lines" => [1, 2, 3, 4, 5, 6]}]
            },
            {
              "linter" => "CoffeeLint",
              "language" => "CoffeeScript",
              "modified_files" => [{"name" => "bad.coffee", "lines" => [1]}]
            },
            {
              "linter" => "CSSLint",
              "language" => "CSS",
              "modified_files" => [{"name" => "bad.css", "lines" => [1, 2, 3, 4]}]
            },
            {
              "linter" => "GoLint",
              "language" => "Go",
              "modified_files" => [{"name" => "bad.go", "lines" => [1, 2, 3, 4, 5, 6, 7]}]
            },
            {
              "linter" => "CheckStyle",
              "language" => "Java",
              "modified_files" => [{"name" => "bad.java", "lines" => [1, 2, 3]}]
            },
            {
              "linter" => "JSHint",
              "language" => "JavaScript",
              "modified_files" => [{"name" => "bad.js", "lines" => [1, 2, 3]}]
            },
            {
              "linter" => "JSONLint",
              "language" => "JSON",
              "modified_files" => [{"name" => "bad.json", "lines" => [1, 2, 3, 4]}]
            },
            {
              "linter" => "RuboCop",
              "language" => "Ruby",
              "modified_files" => [{"name" => "bad.rb", "lines" => [1, 2, 3, 4]}]
            },
            {
              "linter" => "SCSSLint",
              "language" => "SCSS",
              "modified_files" => [{"name" => "bad.scss", "lines" => [1, 2, 3]}]
            },
            {
              "linter" => "Unknown",
              "language" => "Text",
              "modified_files" => [{"name" => "lint.txt", "lines" => [1]}]
            }
          ]
        },
        "meta" =>  {
          "event" => "pull_request",
          "event_id" => "bdb6ec00-5284-11e4-8e22-6dacd62599e2",
          "started_at" => iso8601_regex,
          "finished_at" => iso8601_regex
        }
      }])
    end
  end
end
