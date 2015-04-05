require 'spec_helper'

describe LintTaskRequestedWorker do
  describe '#peform' do
    subject(:worker){described_class.new}
    let(:event){{}}

    it 'delegates to the LintFiles service' do
      expect(LintFiles).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
