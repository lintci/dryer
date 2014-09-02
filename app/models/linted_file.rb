# Wraps information about linted files, like their violations.
class LintedFile
  attr_reader :name, :violations

  def initialize(name)
    @name = name
    @violations = []
  end

  def add_violation(violation)
    @violations << Violation.new(violation)
  end
end
