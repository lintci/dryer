require 'spec_helper'

describe AnalyzeTask do
  subject(:task){build(:task, id: '123')}

  its(:id){is_expected.to eq('123')}
  its(:type){is_expected.to eq('AnalyzeTask')}
  its(:status){is_expected.to eq('started')}
  its(:language){is_expected.to eq('All')}
  its(:tool){is_expected.to eq('Linguist')}
  its(:build){is_expected.to be_a(Build)}
  its(:inspect){is_expected.to eq('<AnalyzeTask: 123 Run Linguist on All files>')}
end
