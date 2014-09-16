require 'spec_helper'

describe LintedFile do
  subject(:file) do
    build(:linted_file).tap do |file|
      file.violations << build(:violation, line: '1')
    end
  end

  its(:name){is_expected.to eq('bad.rb')}
  its(:violations){is_expected.to be_a(Violations)}

  describe '#relevant_violations' do
    include_context 'local git repo'
    let(:modified_files){build(:modified_files, diff: diff)}
    let(:violations){build(:single_violations)}

    it 'returns violations for lines that have been modified' do
      expect(file.relevant_violations(modified_files)).to eq(violations)
    end
  end
end
