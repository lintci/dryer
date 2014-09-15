require 'spec_helper'

describe ModifiedFiles do
  include_context 'local git repo'
  subject(:modified_files){build(:modified_files, diff: diff)}

  after(:each){FileUtils.rm_rf(build(:repo_path))}

  describe '#grouped_by_linter' do
    it 'groups files by their linter and yields them' do
      expect{|b| modified_files.grouped_by_linter(&b)}.to yield_successive_args(
        [Linter::Rubocop, [build(:modified_file, patch: patch)]]
      )
    end
  end
end
