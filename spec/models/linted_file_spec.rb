require 'spec_helper'

describe LintedFile do
  subject(:file){build(:linted_file)}

  its(:name){is_expected.to eq('bad.rb')}
  its(:violations){is_expected.to be_a(Violations)}
end
