require 'spec_helper'
require 'models/violation'

describe Violation do
  subject(:violation){build(:violation)}

  its(:line){is_expected.to eq('2')}
  its(:column){is_expected.to eq('7')}
  its(:length){is_expected.to eq('4')}
  its(:rule){is_expected.to eq('Style/MethodName')}
  its(:severity){is_expected.to eq('convention')}
  its(:message){is_expected.to eq('Use snake_case for methods.')}
  its(:to_comment){is_expected.to eq('Use snake_case for methods.')}
  its(:inspect){is_expected.to eq('<Violation 2:7:4 Style/MethodName:convention:Use snake_case for methods.>')}

  describe '#==' do
    context 'when violation data is the same' do
      let(:duplicate_violation){build(:violation)}

      it 'returns true' do
        expect(violation).to eq(duplicate_violation)
      end
    end

    context 'when violation data is not the same' do
      let(:different_violation){build(:violation, line: '3')}

      it 'returns false' do
        expect(violation).to_not eq(different_violation)
      end
    end
  end
end
