require 'spec_helper'

describe ClassificationSerializer do
  let(:classification){build(:classification, :with_source_files)}
  subject(:serializer){described_class.new(classification)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq(
        classification: {
          task_id: 1,
          source_files: [
            {
              name: 'bad.coffee',
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
              image: false
            }, {
              name: 'bad.js',
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
              image: false
            }, {
              name: 'bad.rb',
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
              image: false
            }
          ]
        }
      )
    end
  end
end
