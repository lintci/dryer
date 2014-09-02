require 'spec_helper'
require 'models/linted_file'
require 'models/violation'

describe LintedFile do
  subject(:file){LintedFile.new('bob.rb')}

  its(:name){is_expected.to eq('bob.rb')}

  describe '#violations' do
    context 'when none have been added' do
      it 'is empty' do
        expect(file.violations).to be_empty
      end
    end

    context 'when a violation is added' do
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
      let(:violation){Violation.new(violation_data)}

      it 'contains the added violation' do
        file.add_violation(violation_data)

        expect(file.violations).to eq([violation])
      end
    end
  end
end
