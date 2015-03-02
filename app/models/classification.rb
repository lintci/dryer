class Classification
  attr_reader :task_id, :groups

  def initialize(task_id, modified_files)
    @task_id = task_id
    @groups = group(modified_files)
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end

private

  def group(modified_files)
    groups = Hash.new do |hash, (linter, language)|
      hash[[linter, language]] = Group.new(linter, language)
    end

    modified_files.each do |file|
      file.linters.each do |linter|
        groups[[linter, file.language]] << file
      end
    end

    groups.values
  end
end
