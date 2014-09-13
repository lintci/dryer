require 'spec_helper'

describe Linter do
  describe '#lint' do
    let(:command){instance_double(PermpressCommand)}
    let(:output) do
      StringIO.new(
        "bad.coffee:1:::camel_case_classes:error:Class names should be camel cased\n"\
        "bad.coffee:2:::camel_case_classes:error:Class names should be camel cased\n"\
        "bad.rb:2:7:4:Style/MethodName:convention:Use snake_case for methods.\n"
      )
    end
    let(:coffee_violation1) do
      build(
        :minimal_violation,
        line: '1',
        rule: 'camel_case_classes',
        severity: 'error',
        message: 'Class names should be camel cased'
      )
    end
    let(:coffee_violation2) do
      build(
        :minimal_violation,
        line: '2',
        rule: 'camel_case_classes',
        severity: 'error',
        message: 'Class names should be camel cased'
      )
    end
    let(:ruby_violation) do
      build(
        :minimal_violation,
        line: '2',
        column: '7',
        length: '4',
        rule: 'Style/MethodName',
        severity: 'convention',
        message: 'Use snake_case for methods.'
      )
    end
    let(:coffee_linted_file) do
      build(
        :linted_file,
        file_name: 'bad.coffee'
      ).tap do |file|
        file.violations << coffee_violation1
        file.violations << coffee_violation2
      end
    end
    let(:ruby_linted_file) do
      build(:linted_file, file_name: 'bad.rb').tap do |file|
        file.violations << ruby_violation
      end
    end
    let(:files){%w(bad.coffee bad.rb)}
    let(:config_file){nil}
    subject(:linter) do
      Class.new(Linter) do
        def command_name
          'rubocop'
        end
      end.new
    end

    it 'parses the output of a linter into linted files' do
      expect(PermpressCommand).to receive(:new).with(linter).and_return(command)
      expect(command).to receive(:run).with(files, config_file).and_yield(output).and_return(1)

      linted_files = []
      result = linter.lint(files, config_file) do |linted_file|
        linted_files << linted_file
      end

      expect(linted_files).to eq([coffee_linted_file, ruby_linted_file])
      expect(result).to eq(false)
    end
  end
end
