require 'spec_helper'

describe ClassifyTaskRequestedWorker do
  describe '#peform' do
    subject(:worker){described_class.new}
    let(:event){{}}

    it 'delegates to the ClassifyFiles service' do
      expect(ClassifyFiles).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
