require 'spec_helper'

describe Linter do
  describe '#lint' do
    let(:first_source_file){build(:source_file)}
    let(:second_source_file){build(:source_file, name: 'bad2.rb')}
    let(:source_files){[first_source_file, second_source_file]}
    let(:violation){build(:violation, violation_attributes)}
    let(:violation_attributes){attributes_for(:violation)}
    let(:workdir){build(:workdir)}
    subject(:linter){Linter.new('RuboCop', workdir, source_files)}

    it 'yields source files with their violations' do
      expect_linter = expect_any_instance_of(LintTrap::Linter::RuboCop)
      expect_linter.to receive(:lint).and_yield(
        violation_attributes.merge(file: File.join(workdir, first_source_file.name))
      ).and_yield(
        violation_attributes.merge(file: File.join(workdir, second_source_file.name))
      )

      expect{|b| linter.lint({}, &b)}.to yield_successive_args(
        [first_source_file.with(violations: [violation]), Time, Time],
        [second_source_file.with(violations: [violation]), Time, Time]
      )
    end

    describe 'integration test', :docker do
      let(:source_files){[first_source_file]}
      let(:violation){build(:violation, line: 3)}
      subject(:linter){Linter.new('RuboCop', build(:fixtures_dir), source_files)}

      it 'yields source files with their violations' do
        linter.lint({}) do |source_file, started_at, finished_at|
          expect(source_file.id).to eq(first_source_file.id)

          source_violation = source_file.violations.first
          expect(source_violation).to have_attributes(
            line: violation.line,
            column: violation.column,
            length: violation.length,
            rule: violation.rule,
            severity: violation.severity,
            message: violation.message
          )

          expect(started_at).to be <= finished_at
        end
      end
    end
  end
end
