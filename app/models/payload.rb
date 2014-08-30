class Payload
  def initialize(data)
    @data = data
  end

  def base_sha
    data['pull_request']['base']['sha']
  end

  def head_sha
    data['pull_request']['head']['sha']
  end

  def branch
    data['pull_request']['head']['ref']
  end

  def clone_url
    data['pull_request']['head']['repo']['git_url']
  end

  def owner
    data['pull_request']['head']['repo']['owner']['login']
  end

  def repo
    data['pull_request']['head']['repo']['name']
  end

private

  attr_reader :data
end
