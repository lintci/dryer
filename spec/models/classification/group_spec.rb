require 'spec_helper'

describe Classification::Group do
  subject(:group){build(:group)}

  its(:linter){is_expected.to eq(LintTrap::Linter::RuboCop.new)}
  its(:language){is_expected.to eq(LintTrap::Language::Ruby.new)}
  its(:modified_files){is_expected.to eq([])}

  describe '#<<' do
    let(:file){build(:modified_file)}

    it 'adds modified files' do
      group << file
      expect(group.modified_files).to eq([file])
    end
  end

  describe '#==' do
    context 'with same grouping' do
      let(:another_group){build(:group)}

      it 'returns true' do
        expect(group).to eq(another_group)
      end
    end

    context 'with different grouping' do
      let(:different_group){build(:group, linter: LintTrap::Language::Go.new)}

      it 'returns false' do
        expect(group).to_not eq(different_group)
      end
    end
  end
end
