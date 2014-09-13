require 'spec_helper'

describe LineViolations do
  subject(:line_violations){build(:line_violations)}

  its(:line){is_expected.to eq('2')}
  its(:inspect) do
    is_expected.to eq(
      '<LineViolations: #2 '\
      "<Violation 2:7:4 Style/MethodName:convention:Use snake_case for methods.>,\n"\
      "\t<Violation 2:7:4 Style/MethodName:convention:Use snake_case for methods.>>"
    )
  end

  describe '#to_comment' do
    it 'generates a grouped comment for each violation' do
      expect(build(:line_violations).to_comment).to eq(
        'Use snake_case for methods.<br>'\
        'Use snake_case for methods.'
      )
    end
  end

  describe '#<<' do
    let(:line_violations){build(:empty_line_violations)}
    let(:empty_line_violations){build(:empty_line_violations)}
    let(:single_line_violations){build(:single_line_violations)}
    let(:violation){build(:violation)}

    it 'adds a violation to the group' do
      expect(line_violations).to eq(empty_line_violations)
      line_violations << violation
      expect(line_violations).to eq(single_line_violations)
    end
  end

  describe '#==' do
    context 'two line_violations with the same violations' do
      it 'returns true' do
        expect(build(:line_violations)).to eq(build(:line_violations))
        expect(build(:empty_line_violations)).to eq(build(:empty_line_violations))
        expect(build(:single_line_violations)).to eq(build(:single_line_violations))
      end
    end

    context 'two line_violations with different violations' do
      it 'returns false' do
        expect(build(:line_violations)).to_not eq(build(:empty_line_violations))
        expect(build(:empty_line_violations)).to_not eq(build(:single_line_violations))
        expect(build(:single_line_violations)).to_not eq(build(:line_violations))
      end
    end
  end
end
