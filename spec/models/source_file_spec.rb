require 'spec_helper'
require 'fileutils'

describe SourceFile do
  let(:workdir){build(:workdir)}
  let(:name){'bad.rb'}
  subject(:file){build(:source_file, workdir: workdir)}

  around(:each) do |example|
    FileUtils.mkdir_p(workdir)
    File.write(file.path, 'class X; end')
    example.run
    File.delete(file.path)
  end

  its(:name){is_expected.to eq(name)}
  its(:modified_lines){is_expected.to eq((1..4).to_a)}
  its(:path){is_expected.to eq(File.join(workdir, name))}
  its(:language){is_expected.to eq(LintTrap::Language::Ruby.new)}
  its(:linters){is_expected.to eq([LintTrap::Linter::RuboCop.new])}
  its(:to_s){is_expected.to eq('bad.rb')}
  its(:inspect) do
    is_expected.to eq(
      '<SourceFile: bad.rb type=Ruby size=31 Bytes modified_lines=[1, 2, 3, 4]'\
      ' binary=false generated=false vendored=false documentation=false image=false>'
    )
  end

  describe '#==' do
    context 'with equivalent modified files' do
      let(:other_file){build(:source_file)}

      it 'returns true' do
        expect(file).to eq(other_file)
      end
    end

    context 'with inequivalent modified files' do
      let(:other_file){build(:source_file, name: 'good.rb')}

      it 'returns false' do
        expect(file).to_not eq(other_file)
      end
    end
  end
end
