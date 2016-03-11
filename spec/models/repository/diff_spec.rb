require 'spec_helper'
require 'fileutils'

describe Repository::Diff do
  let(:workdir){build(:workdir)}
  subject(:diff){build(:diff)}

  after(:each){FileUtils.rm_r(workdir, force: true)}

  describe '#source_files' do
    def have_attributes_for(factory, attributes = {})
      have_attributes(attributes_for(factory, attributes).except(:id))
    end

    it 'produces a list of modified files' do
      expect(diff.source_files).to match(
        [
          have_attributes_for(:java_source_file, name: 'Good.java', modified_lines: (1..6).to_a, size: 80, sha: 'ff0d65aad488c95d21821be4f258cb139685ba44'),
          have_attributes_for(:coffeescript_source_file),
          have_attributes_for(:css_source_file),
          have_attributes_for(:go_source_file),
          have_attributes_for(:java_source_file),
          have_attributes_for(:javascript_source_file),
          have_attributes_for(:json_source_file),
          have_attributes_for(:ruby_source_file),
          have_attributes_for(:scss_source_file),
          have_attributes_for(:text_source_file)
        ]
      )
    end
  end
end
