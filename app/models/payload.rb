class Payload
  def initialize(data)
    @data = data
  end

  def base_sha
    data.base.sha
  end

  def head_sha
    data.head.sha
  end

  def branch
    data.head.ref
  end

  def ssh_url
    data.head.repo.ssh_url
  end

  def owner
    data.head.repo.owner.login
  end

  def project
    data.head.repo.name
  end

private

  attr_reader :data
end
