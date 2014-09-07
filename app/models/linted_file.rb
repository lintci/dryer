# Wraps information about linted files, like their violations.
class LintedFile
  attr_reader :name, :violations

  def initialize(name)
    @name = name
    @violations = Violations.new
  end

  def relevant_violations(modified_files)
    modified_lines = modified_files[name].modified_lines

    violations.filter_by_lines(modified_lines)
  end
end
