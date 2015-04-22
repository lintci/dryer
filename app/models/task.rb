require 'pathname'

class Task
  include Virtus.value_object

  values do
    attribute :id, Integer
    attribute :type, String
    attribute :status, String
    attribute :language, String
    attribute :tool, String
    attribute :build, Build
  end

  delegate :pull_request, to: :build
  delegate :head_sha, :base_sha, :clone_url, to: :pull_request

  def slug
    "#{build.slug}/#{id}"
  end

  def inspect
    "<#{self.class.name}: #{id} Run #{tool} on #{language} files>"
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
