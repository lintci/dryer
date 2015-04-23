# A set of tasks to be perfomed
class Build
  include Virtus.value_object

  values do
    attribute :id, Integer
    attribute :pull_request, PullRequest
  end

  delegate :clone_url, to: :pull_request

  def slug
    "#{pull_request.slug}/#{id}"
  end

  def inspect
    "<Build: #{id}>"
  end
end
