require 'spec_helper'

describe ViolationSerializer do
  let(:violation){build(:violation)}
  subject(:serializer){described_class.new(violation)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq(
        violation: {
          line: 2,
          column: 7,
          length: 4,
          rule: 'Style/MethodName',
          severity: 'convention',
          message: 'Use snake_case for methods.'
        }
      )
    end
  end
end
