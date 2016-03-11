require 'spec_helper'

describe Msg::V1::ViolationSerializer do
  let(:object){build(:violation)}
  subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to be_json_api_resource('violation').
                                    with_attributes(
                                      column: 7,
                                      length: 4,
                                      line: 2,
                                      message: 'Use snake_case for method names.',
                                      rule: 'Style/MethodName',
                                      severity: 'convention'
                                    )
    end
  end
end
