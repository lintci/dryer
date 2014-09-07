# Wraps violations by line number
class Violations
  def initialize(violations = {})
    @violations = violations.dup
    @violations.default_proc = proc{|h, k| h[k] = LineViolations.new(k)}
  end

  def <<(violation_data)
    violation = Violation.new(violation_data)
    violations[violation.line] << violation
  end

  def grouped_by_line
    @violations.each(&Proc.new)
  end

  def filter_by_lines(lines)
    violations_data = lines.map do |line|
      [line, violations[line]] if violations[line]
    end.compact.to_h

    Violations.new(violations_data)
  end

  def ==(other)
    violations == other.violations
  end

protected

  attr_reader :violations
end
