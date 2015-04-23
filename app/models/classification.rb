# A set of files and their inspected attributes
class Classification
  include Virtus.value_object

  values do
    attribute :task_id, Integer
    attribute :source_files, Array[SourceFile]
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
