class Linter
  # Wraps the execution of rubocop
  class Rubocop < Linter
    def command_name
      'rubocop'
    end
  end
end
