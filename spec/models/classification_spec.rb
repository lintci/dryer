require 'spec_helper'

describe Analysis do
  let(:task_id){1}
  let(:cs_file){build(:coffeescript_source_file)}
  let(:js_file){build(:javascript_source_file)}
  let(:ruby_file){build(:ruby_source_file)}
  let(:txt_file){build(:text_source_file)}
  let(:source_files){[cs_file, js_file, ruby_file, txt_file]}
  subject(:analysis){described_class.new(task_id: task_id, source_files: source_files)}

  its(:task_id){is_expected.to eq(task_id)}
  its(:source_files){is_expected.to eq(source_files)}
end
