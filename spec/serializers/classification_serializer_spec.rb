require 'spec_helper'

describe ClassificationSerializer do
  let(:classification){build(:classification, :with_modified_files)}
  subject(:serializer){described_class.new(classification)}

  describe 'as_json' do
    it 'returns the expected data' do
      expect(serializer.as_json).to eq({
        classification: {
          task_id: 1,
          groups: [{
            linter: 'CoffeeLint',
            language: 'CoffeeScript',
            modified_files: [{
              name: 'bad.coffee',
              lines: [1]
            }]
          }, {
            linter: 'JSHint',
            language: 'JavaScript',
            modified_files: [{
              name: 'bad.js',
              lines: [1, 2, 3]
            }]
          }, {
            linter: 'RuboCop',
            language: 'Ruby',
            modified_files: [{
              name: 'bad.rb',
              lines: [1, 2, 3, 4]
            }]
          }]
        }
      })
    end
  end
end
