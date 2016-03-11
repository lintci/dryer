require 'spec_helper'

describe Msg::V1::LintTaskSerializer do
  let(:object){build(:lint_task)}
  subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to be_json_api_resource('lint_task').
                                    with_relationships(:source_files).
                                    with_attributes(
                                      language: 'Ruby',
                                      status: 'started',
                                      tool: 'RuboCop',
                                      type: 'LintTask'
                                    )
    end
  end
end
