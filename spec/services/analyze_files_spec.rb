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
      expect(started_job['args'].first).to be_json_api_resource('analyze_task').
                                           with_meta(
                                             event: 'pull_request',
                                             event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                             task_started_at: be_timestamp
                                           )

      completed_job = AnalyzeTaskCompletedWorker.jobs.last
      expect(completed_job['args'].first).to be_json_api_resource('analyze_task').
                                       including('source_files').
                                       with_meta(
                                         event: 'pull_request',
                                         event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                         task_started_at: be_timestamp,
                                         task_finished_at: be_timestamp
                                       )
    end
  end
end
