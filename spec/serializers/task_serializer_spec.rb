require 'spec_helper'

describe TaskSerializer do
  let(:task){build(:task)}
  subject(:serializer){described_class.new(task)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq(
        task: {
          id: 1,
          type: 'AnalyzeTask',
          language: 'All',
          tool: 'Linguist'
        }
      )
    end
  end
end
