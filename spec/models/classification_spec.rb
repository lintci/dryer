require 'spec_helper'

describe Classification do
  let(:task_id){1}
  let(:cs_file){build(:coffeescript_modified_file)}
  let(:js_file){build(:javascript_modified_file)}
  let(:ruby_file){build(:ruby_modified_file)}
  let(:txt_file){build(:text_modified_file)}
  let(:modified_files){[cs_file, js_file, ruby_file, txt_file]}
  subject(:classification){described_class.new(task_id, modified_files)}

  its(:task_id){is_expected.to eq(task_id)}

  context 'it classifies all files with linters into groups' do
    its(:groups) do
      is_expected.to eq([
        described_class::Group.new(cs_file.linters.first, cs_file.language, [cs_file]),
        described_class::Group.new(js_file.linters.first, js_file.language, [js_file]),
        described_class::Group.new(ruby_file.linters.first, ruby_file.language, [ruby_file])
      ])
    end
  end
end
