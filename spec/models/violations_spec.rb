require 'spec_helper'
require 'models/violations'
require 'models/line_violations'
require 'models/violation'

describe Violations do
  describe '#grouped_by_line' do
    let(:violations){build(:violations)}

    it 'yields each line and set of violations' do
      expect{|b| violations.grouped_by_line(&b)}.to yield_successive_args(
        ['1', build(:single_line_violations, line: '1')],
        ['2', build(:line_violations, line: '2')]
      )
    end
  end

  describe '#filter_by_lines' do
    let(:violations){build(:violations)}
    let(:first_line_violations){build(:single_violations)}

    it 'returns a new violations with just the specified lines' do
      expect(violations.filter_by_lines(['1'])).to eq(first_line_violations)
    end
  end

  describe '#<<' do
    let(:violations){build(:empty_violations)}
    let(:empty_violations){build(:empty_violations)}
    let(:single_violations){build(:single_violations)}
    let(:violation_data){attributes_for(:violation, line: '1')}

    it 'adds a violation to the group' do
      expect(violations).to eq(empty_violations)
      violations << violation_data
      expect(violations).to eq(single_violations)
    end
  end

  describe '#==' do
    context 'with two equivalent violations' do
      it 'returns true' do
        expect(build(:violations)).to eq(build(:violations))
        expect(build(:empty_violations)).to eq(build(:empty_violations))
        expect(build(:single_violations)).to eq(build(:single_violations))
      end
    end

    context 'with two inequivalent violations' do
      it 'returns false' do
        expect(build(:violations)).to_not eq(build(:empty_violations))
        expect(build(:empty_violations)).to_not eq(build(:single_violations))
        expect(build(:single_violations)).to_not eq(build(:violations))
      end
    end
  end
end
