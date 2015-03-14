require 'spec_helper'

describe ClassifyTaskRequestedWorker do
  describe '#peform' do
    subject(:worker){described_class.new}
    let(:event){{}}

    it 'delegates to the ClassifyChanges service' do
      expect(ClassifyChanges).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
