# Wraps information about linting violations
class Violation
  ERROR = 'error'
  WARNING = 'warning'

  attr_reader :line, :column, :length, :rule, :severity, :message
  alias_method :to_comment, :message

  # rubocop:disable Metrics/ParameterLists
  def initialize(line: 0, column: 0, length: 0, rule: nil, severity: ERROR, message: nil, **)
    @line = line
    @column = column
    @length = length
    @rule = rule
    @severity = severity
    @message = message
  end
  # rubocop:enable Metrics/ParameterLists

  def ==(other)
    line == other.line &&
      column == other.column &&
      length == other.length &&
      rule == other.rule &&
      severity == other.severity &&
      message == other.message
  end

  def inspect
    "<Violation #{line}:#{column}:#{length} #{rule}:#{severity}:#{message}>"
  end
end
