# Wraps data about a pull request
class PullRequest
  attr_reader :id, :base_sha, :head_sha, :branch, :clone_url, :owner, :repo

  def initialize(data)
    @id, @base_sha, @head_sha, @branch, @clone_url, @owner, @repo = data.values_at(
      'id', 'base_sha', 'head_sha', 'branch', 'clone_url', 'owner', 'repo'
    )
  end

  def ==(other)
    id == other.id && owner = other.owner && repo == other.repo
  end

  def slug
    "#{owner}/#{repo}/#{head_sha}"
  end

  def inspect
    "<PullRequest:#{owner}/#{repo} (#{base_sha[0..6]}...#{head_sha[0..6]})>"
  end
end
