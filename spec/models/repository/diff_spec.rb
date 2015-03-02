require 'spec_helper'
require 'fileutils'

describe Repository::Diff do
  let(:workdir){build(:workdir)}
  subject(:diff){build(:diff)}

  after(:each){FileUtils.rm_r(workdir, force: true)}

  describe '#modified_files' do
    it 'produces a list of modified files' do
      expect(diff.modified_files).to eq([
        build(:java_modified_file, name: 'Good.java', lines: (1..6).to_a),
        build(:coffeescript_modified_file),
        build(:css_modified_file),
        build(:go_modified_file),
        build(:java_modified_file),
        build(:javascript_modified_file),
        build(:json_modified_file),
        build(:ruby_modified_file),
        build(:scss_modified_file),
        build(:text_modified_file)
      ])
    end
  end
end
