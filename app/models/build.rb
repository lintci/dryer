class Build
  attr_reader :id

  delegate :clone_url, to: :pull_request

  def initialize(data)
    @id, @pull_request = data.values_at('id', 'pull_request')
  end

  def pull_request
    PullRequest.new(@pull_request)
  end

  def slug
    "#{pull_request.slug}/#{id}"
  end

  def inspect
    "<Build: #{id}>"
  end
end
