# Wraps a group of violations
class LineViolations
  attr_reader :line

  def initialize(line, violations = [])
    @line = line
    @violations = violations
  end

  delegate :<<, to: :violations

  def ==(other)
    line == other.line &&
      violations == other.violations
  end

  def to_comment
    violations.map(&:to_comment).join('<br>')
  end

  def inspect
    "<LineViolations: ##{line} #{violations.map(&:inspect).join("\n")}>"
  end

protected

  attr_reader :violations
end
