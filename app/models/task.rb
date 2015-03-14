require 'pathname'

class Task
  attr_reader :id, :type, :status, :language, :tool

  delegate :pull_request, to: :build
  delegate :head_sha, :base_sha, :clone_url, to: :pull_request

  def initialize(data)
    @id, @type, @status, @language, @tool, @build = data.values_at(
      'id', 'type', 'status', 'language', 'tool', 'build'
    )
  end

  def build
    Build.new(@build)
  end

  def slug
    "#{build.slug}/#{id}"
  end

  def inspect
    "<Task: #{id} Run #{tool} on #{language} files>"
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
