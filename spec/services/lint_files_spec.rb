require 'spec_helper'

describe LintFiles do
  describe '#call' do
    let(:event){build(:lint_task_requested_event)}
    subject(:service){described_class.new(event)}


  end
end
