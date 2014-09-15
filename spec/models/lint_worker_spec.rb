require 'spec_helper'

describe LintWorker do
  describe 'thread' do
    let(:pull_request){build(:pull_request)}
    let(:linter){instance_double(Linter, command_name: rubocop)}
    let(:modified_files){}

    it 'lints the modified files and comments on the violations found' do

    end
  end
end
