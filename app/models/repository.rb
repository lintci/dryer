require 'rugged'
require 'fileutils'
require_relative 'repository/diff'

# Provides the ability to clone a repository to a standard location and
# provide access to that repository.
class Repository
  class << self
    def clone(repos_dir, task)
      repo = Rugged::Repository.clone_at(
        task.clone_url,
        File.join(repos_dir, task.slug)
      )
      repo.checkout(task.head_sha, strategy: :force)

      repository = new(repo)

      if block_given?
        yield repository

        repository.destroy!
      end

      repository
    end
  end

  def initialize(repo)
    @repo = repo
  end

  def diff(base_sha, head_sha)
    Repository::Diff.new(repo, base_sha, head_sha)
  end

  def modified_files(base_sha, head_sha)
    diff(base_sha, head_sha).modified_files
  end

  def head_sha
    repo.head.target.oid
  end

  def destroy!
    FileUtils.rm_rf(repo.workdir)
  end

  def inspect
    "<Repository: #{repo.workdir}>"
  end

private

  attr_reader :repo
end
