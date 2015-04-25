require 'spec_helper'

describe Linting do
  subject(:linting){build(:linting)}

  its(:task_id){is_expected.to eq(1)}
  it{is_expected.to_not be_clean}
end
