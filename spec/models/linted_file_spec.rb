require 'spec_helper'
require 'models/linted_file'
require 'models/violation'

describe LintedFile do
  subject(:file){build(:linted_file)}

  its(:name){is_expected.to eq('bad.rb')}
  its(:violations){is_expected.to be_a(Violations)}
end
