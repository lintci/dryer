# Wraps data about a pull request
class PullRequest
  extend ActiveModel::Naming
  include Virtus.value_object

  values do
    attribute :id, Integer
    attribute :base_sha, String
    attribute :head_sha, String
    attribute :branch, String
    attribute :clone_url, String
    attribute :owner, String
    attribute :repo, String
  end

  def slug
    "#{owner}/#{repo}/#{head_sha}"
  end

  def inspect
    "<PullRequest:#{owner}/#{repo} (#{base_sha[0..6]}...#{head_sha[0..6]})>"
  end
end
