require 'spec_helper'

describe ModifiedFile do
  include_context 'local git repo'

  subject(:file){build(:modified_file, patch: patch)}

  its(:name){is_expected.to eq('bad.rb')}
  its(:modified_lines){is_expected.to eq(['1'])}
  its(:path){is_expected.to match(%r{tmp/repos/test/bad\.rb$})}
  its(:language){is_expected.to be_a(Language::Ruby)}
  its(:linters){is_expected.to eq([Linter::Rubocop])}
  its(:to_s){is_expected.to eq('bad.rb')}
  its(:inspect){is_expected.to eq('<ModifiedFile: bad.rb [1]>')}

  describe '#==' do
    context 'with equivalent modified files' do
      let(:other_file){build(:modified_file, patch: patch)}

      it 'returns true' do
        expect(file).to eq(other_file)
      end
    end

    context 'with inequivalent modified files' do
      let(:other_file){build(:modified_file, patch: patch, path: '/root')}

      it 'returns false' do
        expect(file).to_not eq(other_file)
      end
    end
  end
end
