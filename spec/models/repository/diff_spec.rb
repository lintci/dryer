require 'spec_helper'
require 'fileutils'

describe Repository::Diff do
  let(:workdir){build(:workdir)}
  subject(:diff){build(:diff)}

  after(:each){FileUtils.rm_r(workdir, force: true)}

  describe '#modified_files' do
    it 'produces a list of modified files' do
      expect(diff.modified_files).to eq([
        ModifiedFile.new(workdir, 'Good.java', (1..6).to_a),
        ModifiedFile.new(workdir, 'bad.coffee', [1]),
        ModifiedFile.new(workdir, 'bad.css', (1..4).to_a),
        ModifiedFile.new(workdir, 'bad.go', (1..7).to_a),
        ModifiedFile.new(workdir, 'bad.java', (1..3).to_a),
        ModifiedFile.new(workdir, 'bad.js', (1..3).to_a),
        ModifiedFile.new(workdir, 'bad.json', (1..4).to_a),
        ModifiedFile.new(workdir, 'bad.rb', (1..4).to_a),
        ModifiedFile.new(workdir, 'bad.scss', (1..3).to_a),
        ModifiedFile.new(workdir, 'lint.txt', [1])
      ])
    end
  end
end
