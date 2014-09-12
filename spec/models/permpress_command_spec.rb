require 'spec_helper'

describe PermpressCommand do
  let(:linter){double(Linter, command_name: 'rubocop')}
  subject(:command){PermpressCommand.new(linter)}

  describe '#run' do
    let(:stdin){double(:stdin, class: IO)}
    let(:stdout){double(:stdout, class: IO)}
    let(:stderr){double(:stderr, class: IO)}
    let(:thread){instance_double(Thread)}

    it 'executes, yields the output, and returns the exit status' do
      expect(Open3).to receive(:popen3)
                       .with('permpress rubocop lint bad.rb 2>&1')
                       .and_yield(stdin, stdout, stderr, thread)

      expect(thread).to receive_message_chain(:value, :exitstatus)
                        .and_return(1)

      exit_status = command.run(['bad.rb'], nil) do |io|
        expect(io).to eq(stdout)
      end

      expect(exit_status).to eq(1)
    end
  end

  describe '#command' do
    context 'when config file is specified' do
      it 'generates the correct command' do
        expect(command.command(['bad.rb'], '.rubocop.yml')).to eq(
          'permpress rubocop lint --config .rubocop.yml bad.rb 2>&1'
        )
      end
    end

    context 'when config file is not specified' do
      it 'generates the correct command' do
        expect(command.command(['bad.rb'], nil)).to eq(
          'permpress rubocop lint bad.rb 2>&1'
        )
      end
    end
  end
end
