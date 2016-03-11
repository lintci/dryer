require 'spec_helper'

describe Msg::V1::SourceFileSerializer do
  let(:object){build(:source_file, :with_violations)}
  subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to be_json_api_resource('source_file').
                                    with_relationships(:violations).
                                    with_attributes(
                                      binary: false,
                                      documentation: false,
                                      extension: '.rb',
                                      generated: false,
                                      image: false,
                                      language: 'Ruby',
                                      linters: ['RuboCop'],
                                      modified_lines: [1, 2, 3, 4],
                                      name: 'bad.rb',
                                      sha: 'cbc7b6a779837b93563e69511d44cb35051ed712',
                                      size: 31,
                                      source_type: 'Ruby',
                                      vendored: false
                                    )
    end
  end
end
