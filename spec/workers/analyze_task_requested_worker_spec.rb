require 'spec_helper'

describe AnalyzeTaskRequestedWorker do
  describe '#peform' do
    subject(:worker){described_class.new}
    let(:event){{}}

    it 'delegates to the AnalyzeFiles service' do
      expect(AnalyzeFiles).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
