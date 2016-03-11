require 'securerandom'

# Wraps information about linting violations
class Violation
  extend ActiveModel::Naming
  include Virtus.value_object

  ERROR = 'error'.freeze
  WARNING = 'warning'.freeze

  values do
    attribute :id, String, default: ->(*){SecureRandom.uuid}
    attribute :line, Integer
    attribute :column, Integer
    attribute :length, Integer
    attribute :rule, String
    attribute :severity, String
    attribute :message, String
  end

  def initialize(attrs = {})
    super
    self.line ||= 0
    self.column ||= 0
    self.length ||= 0
    self.severity ||= ERROR
  end

  def inspect
    "<Violation: #{id} #{line}:#{column}:#{length} #{rule}:#{severity}:#{message}>"
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
