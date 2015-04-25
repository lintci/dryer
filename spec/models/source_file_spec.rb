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
  its(:sha){is_expected.to eq('cbc7b6a779837b93563e69511d44cb35051ed712')}
  its(:workdir){is_expected.to eq(workdir)}
  its(:modified_lines){is_expected.to eq((1..4).to_a)}
  its(:path){is_expected.to eq(File.join(workdir, name))}
  its(:language){is_expected.to eq(LintTrap::Language::Ruby.new)}
  its(:linters){is_expected.to eq([LintTrap::Linter::RuboCop.new])}
  its(:size){is_expected.to eq(31)}
  its(:extension){is_expected.to eq('.rb')}
  it{is_expected.to_not be_binary}
  it{is_expected.to_not be_generated}
  it{is_expected.to_not be_vendored}
  it{is_expected.to_not be_documentation}
  it{is_expected.to_not be_image}
  its(:violations){is_expected.to eq([])}
  its(:to_s){is_expected.to eq('bad.rb')}
  its(:inspect) do
    is_expected.to eq(
      '<SourceFile: bad.rb sha=cbc7b6 type=Ruby size=31 Bytes modified_lines=[1, 2, 3, 4]'\
      ' binary=false generated=false vendored=false documentation=false image=false>'
    )
  end

  describe '#source_type' do
    context 'when source file has a language' do
      subject(:file){build(:ruby_source_file)}

      it 'retuns the language' do
        expect(file.source_type).to eq('Ruby')
      end
    end

    context 'when source file is an image' do
      subject(:file){build(:png_source_file)}

      it 'returns the image type' do
        expect(file.source_type).to eq('PNG')
      end
    end

    context 'when source file is documentation' do
      subject(:file){build(:license_source_file)}

      it 'returns Documentation' do
        expect(file.source_type).to eq('Documentation')
      end
    end

    context 'when source file is an image' do
      subject(:file){build(:pdf_source_file)}

      it 'returns Binary' do
        expect(file.source_type).to eq('Binary')
      end
    end
  end
end
