require 'spec_helper'
require 'models/violation'

describe Violation do
  let(:violation_data) do
    {
      file: 'bob.rb',
      line: 1,
      column: 2,
      length: 3,
      rule: 'Less Code',
      severity: Violation::ERROR,
      message: 'No code allowed here.'
    }
  end
  subject(:violation){Violation.new(violation_data)}

  its(:line){is_expected.to eq(1)}
  its(:column){is_expected.to eq(2)}
  its(:length){is_expected.to eq(3)}
  its(:rule){is_expected.to eq('Less Code')}
  its(:severity){is_expected.to eq(Violation::ERROR)}
  its(:message){is_expected.to eq('No code allowed here.')}
  its(:inspect){is_expected.to eq('<Violation 1:2:3 Less Code:error:No code allowed here.>')}

  describe '#==' do
    context 'when violation data is the same' do
      let(:duplicate_violation){Violation.new(violation_data)}

      it 'returns true' do
        expect(violation).to eq(duplicate_violation)
      end
    end

    context 'when violation data is not the same' do
      let(:different_violation_data) do
        violation_data.dup.tap do |data|
          data[:line] = 5
        end
      end
      let(:different_violation){Violation.new(different_violation_data)}

      it 'returns false' do
        expect(violation).to_not eq(different_violation)
      end
    end
  end
end
