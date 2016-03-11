require 'spec_helper'

describe Msg::V1::AnalyzeTaskSerializer do
  let(:object){build(:analyze_task, :with_source_files)}
  subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to be_json_api_resource('analyze_task').
                                    with_relationships(:source_files).
                                    with_attributes(
                                      language: 'All',
                                      status: 'started',
                                      tool: 'Linguist',
                                      type: 'AnalyzeTask'
                                    )
    end
  end
end
