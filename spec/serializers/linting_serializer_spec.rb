require 'spec_helper'

describe LintingSerializer do
  let(:linting){build(:linting)}
  subject(:serializer){described_class.new(linting)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq(
        linting: {
          task_id: 1,
          clean: false
        }
      )
    end
  end
end
