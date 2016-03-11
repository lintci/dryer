# A set of tasks to be perfomed
class Build
  extend ActiveModel::Naming
  include Virtus.value_object

  values do
    attribute :id, String
    attribute :ssh_public_key, String
    attribute :ssh_private_key, String
    attribute :pull_request, PullRequest
  end

  delegate :clone_url, to: :pull_request

  def slug
    "#{pull_request.slug}/#{id}"
  end

  def inspect
    "<Build: #{id}>"
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end
end
