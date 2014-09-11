require 'spec_helper'

describe ModifiedFile do
  include_context 'local git repo'

  subject(:file){ModifiedFile.new(patch, repo_path)}

  its(:name){is_expected.to eq('bad.rb')}
  its(:modified_lines){is_expected.to eq([1])}
  its(:path){is_expected.to match(%r{tmp/repos/test/bad\.rb$})}
end
