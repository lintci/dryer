require 'spec_helper'
require 'fileutils'

describe Repository::Diff do
  let(:workdir){build(:workdir)}
  subject(:diff){build(:diff)}

  after(:each){FileUtils.rm_r(workdir, force: true)}

  describe '#source_files' do
    it 'produces a list of modified files' do
      expect(diff.source_files).to eq([
        build(:java_source_file, name: 'Good.java', modified_lines: (1..6).to_a, size: 80),
        build(:coffeescript_source_file),
        build(:css_source_file),
        build(:go_source_file),
        build(:java_source_file),
        build(:javascript_source_file),
        build(:json_source_file),
        build(:ruby_source_file),
        build(:scss_source_file),
        build(:text_source_file)
      ])
    end
  end
end
