require 'spec_helper'

describe LintWorker do
  xdescribe 'thread' do
    include_context 'local git repo'
    let(:pull_request){build(:pull_request)}
    let(:linter){instance_double(Linter, command_name: 'rubocop')}
    let(:modified_files){build(:modified_files, diff: diff)}
    let(:linted_file) do
      build(:linted_file).tap do |file|
        file.violations << build(:violation, line: '1')
      end
    end
    let(:config_file){nil}
    subject(:lint_worker){LintWorker.new(pull_request, linter, modified_files, config_file, Subscription.new)}

    it 'lints the modified files and comments on the violations found' do
      expect(pull_request).to receive(:comment).with(linted_file, '1', 'Use snake_case for methods.')
      expect(linter).to receive(:lint).with(modified_files, config_file).and_yield(linted_file).and_return(true)

      expect(lint_worker.value).to eq(true)
    end
  end
end
