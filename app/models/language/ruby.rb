class Language
  # Tracks information about ruby as it pertains to linting
  class Ruby < Language
    def name
      'Ruby'
    end

    def default_linters
      [Linter::Rubocop]
    end

    def linters
      [Linter::Rubocop]
    end
  end
end
