# The result of linting a set of files
class Linting
  include Virtus.value_object

  values do
    attribute :task_id, Integer
    attribute :clean, Boolean
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
