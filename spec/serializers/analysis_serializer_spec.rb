require 'spec_helper'

describe AnalysisSerializer do
  let(:analysis){build(:analysis, :with_source_files)}
  subject(:serializer){described_class.new(analysis)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq(
        analysis: {
          task_id: 1,
          source_files: [
            {
              name: 'bad.coffee',
              sha: 'b045a0f5309273ce68e7cb52fc020769cef4a874',
              language: 'CoffeeScript',
              linters: ['CoffeeLint'],
              modified_lines: [1],
              source_type: 'CoffeeScript',
              size: 11,
              extension: '.coffee',
              binary: false,
              generated: false,
              vendored: false,
              documentation: false,
              image: false,
              violations: []
            }, {
              name: 'bad.js',
              sha: 'c6e2cbd471ae9be3ccd9657c4a28161fdf0b5454',
              language: 'JavaScript',
              linters: ['JSHint'],
              modified_lines: [1, 2, 3],
              source_type: 'JavaScript',
              size: 40,
              extension: '.js',
              binary: false,
              generated: false,
              vendored: false,
              documentation: false,
              image: false,
              violations: []
            }, {
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
          ]
        }
      )
    end
  end
end
