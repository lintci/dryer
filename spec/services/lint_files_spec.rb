require 'spec_helper'

describe LintFiles do
  describe '#call' do
    let(:event){build(:lint_task_requested_event)}
    let(:violation_attributes){attributes_for(:violation)}
    let(:workdir){File.join(build(:repos_dir), 'lintci', 'guinea_pig', '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e', '1848cc64-fd0f-400d-a382-0b0288a75ed0', '76dca915-48e0-42fe-b8df-e57298039479')}
    subject(:service){described_class}

    it 'sends task started, file linted, and task finished events' do
      expect_linter = expect_any_instance_of(LintTrap::Linter::RuboCop)
      expect_linter.to receive(:lint).and_yield(
        violation_attributes.merge(file: File.join(workdir, 'bad.rb'))
      )
      expect_any_instance_of(LintTrap::Container::Docker).to receive(:pull).and_return(
        ['lintci/rubocop', Time.stamp_time, Time.stamp_time]
      )

      expect do
        expect do
          expect do
            subject.call(event)
          end.to change{LintTaskCompletedWorker.jobs.size}.by(1)
        end.to change{FileLintedWorker.jobs.size}.by(1)
      end.to change{TaskStartedWorker.jobs.size}.by(1)

      started_job = TaskStartedWorker.jobs.last
      expect(started_job['args'].first).to  be_json_api_resource('lint_task').
                                            with_meta(
                                              event: 'pull_request',
                                              event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                              task_started_at: be_timestamp
                                            )

      linted_file_job = FileLintedWorker.jobs.last
      expect(linted_file_job['args'].first).to be_json_api_resource('lint_task').
                                               including(source_files: :violations).
                                               with_meta(
                                                 event: 'pull_request',
                                                 event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                                 task_started_at: be_timestamp,
                                                 setup_started_at: be_timestamp,
                                                 setup_finished_at: be_timestamp,
                                                 docker_image: match(%r<lintci/rubocop:\d+\.\d+\.\d+>),
                                                 started_at: be_timestamp,
                                                 finished_at: be_timestamp
                                               )


      completed_job = LintTaskCompletedWorker.jobs.last
      expect(completed_job['args'].first).to be_json_api_resource('lint_task').
                                             with_meta(
                                               event: 'pull_request',
                                               event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                               task_started_at: be_timestamp,
                                               task_finished_at: be_timestamp,
                                               setup_started_at: be_timestamp,
                                               setup_finished_at: be_timestamp,
                                               docker_image: match(%r<lintci/rubocop:\d+\.\d+\.\d+>),
                                               clean: false
                                             )
    end
  end
end
