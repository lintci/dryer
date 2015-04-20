require 'spec_helper'

describe Linter do
  describe '#lint' do
    let(:first_source_file){build(:source_file)}
    let(:second_source_file){build(:source_file, name: 'bad2.rb')}
    let(:source_files){[first_source_file, second_source_file]}
    let(:violation){build(:violation)}
    let(:violation_attributes){attributes_for(:violation)}
    subject(:linter){Linter.new('RuboCop', build(:workdir), source_files)}

    it 'yields source files with their violations' do
      expect_linter = expect_any_instance_of(LintTrap::Linter::RuboCop)
      expect_linter.to receive(:lint).and_yield(
        violation_attributes.merge(file: first_source_file.name)
      ).and_yield(
        violation_attributes.merge(file: second_source_file.name)
      )

      expect{|b| linter.lint({}, &b)}.to yield_successive_args(
        [first_source_file.with(violations: [violation]), Time, Time],
        [second_source_file.with(violations: [violation]), Time, Time]
      )
    end
  end
end
