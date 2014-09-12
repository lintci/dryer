require 'spec_helper'

describe Linter do
  describe '#lint' do
    let(:command){instance_double(PermpressCommand)}
    let(:output) do
      StringIO.new(
        "bad.coffee:1:::camel_case_classes:error:Class names should be camel cased\n"\
        "bad.coffee:2:::camel_case_classes:error:Class names should be camel cased\n"\
        "bad.rb:2:7:4:Style/MethodName:convention:Use snake_case for methods.\n"\
        "bad.rb:5:7:4:Style/MethodName:convention:Use snake_case for methods.\n"\
        "bad.scss:2:3:12:BorderZero:warning:`border: 0;` is preferred over `border: none;`\n"
      )
    end

    pending 'parses the output of a linter into linted files' do
      expect(PermpressCommand).to receive(:new).with(linter).and_return(command)
      expect(command).to receive(:run).and_yield(output)
    end
  end
end
