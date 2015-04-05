class Classification
  attr_reader :task_id, :source_files

  def initialize(task_id, source_files)
    @task_id = task_id
    @source_files = source_files
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
