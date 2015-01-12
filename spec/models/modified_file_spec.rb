require 'spec_helper'
require 'fileutils'

describe ModifiedFile do
  let(:workdir){build(:workdir)}
  let(:name){'bad.rb'}
  subject(:file){build(:modified_file, workdir: workdir)}

  around(:each) do |example|
    FileUtils.mkdir_p(workdir)
    File.write(file.path, 'class X; end')
    example.run
    File.delete(file.path)
  end

  its(:name){is_expected.to eq(name)}
  its(:lines){is_expected.to eq([1, 2, 3])}
  its(:path){is_expected.to eq(File.join(workdir, name))}
  its(:language){is_expected.to eq(LintTrap::Language::Ruby.new)}
  its(:linters){is_expected.to eq([LintTrap::Linter::RuboCop.new])}
  its(:to_s){is_expected.to eq('bad.rb')}
  its(:inspect){is_expected.to eq("<ModifiedFile: #{workdir}/bad.rb [1, 2, 3]>")}

  describe '#==' do
    context 'with equivalent modified files' do
      let(:other_file){build(:modified_file)}

      it 'returns true' do
        expect(file).to eq(other_file)
      end
    end

    context 'with inequivalent modified files' do
      let(:other_file){build(:modified_file, name: 'good.rb')}

      it 'returns false' do
        expect(file).to_not eq(other_file)
      end
    end
  end
end
