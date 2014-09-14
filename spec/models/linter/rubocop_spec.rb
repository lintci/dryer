require 'spec_helper'

describe Linter::Rubocop do
  subject(:linter){Linter::Rubocop.new}

  its(:command_name){is_expected.to eq('rubocop')}
end
