require 'spec_helper'

describe SourceFileSerializer do
  let(:source_file){build(:source_file)}
  subject(:serializer){described_class.new(source_file)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq(
        source_file: {
          name: 'bad.rb',
          sha: 'cbc7b6a779837b93563e69511d44cb35051ed712',
          language: 'Ruby',
          linters: ['RuboCop'],
          modified_lines: [1, 2, 3, 4],
          source_type: 'Ruby',
          size: 31,
          extension: '.rb',
          binary: false,
          generated: false,
          vendored: false,
          documentation: false,
          image: false,
          violations: []
        }
      )
    end
  end
end
