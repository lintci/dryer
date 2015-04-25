require 'spec_helper'

describe Task do
  subject(:task){build(:task)}

  its(:id){is_expected.to eq(1)}
  its(:type){is_expected.to eq('AnalyzeTask')}
  its(:status){is_expected.to eq('queued')}
  its(:language){is_expected.to eq('All')}
  its(:tool){is_expected.to eq('Linguist')}
  its(:build){is_expected.to be_a(Build)}
  its(:inspect){is_expected.to eq('<Task: 1 Run Linguist on All files>')}
end
