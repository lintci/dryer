require 'rugged'
require 'fileutils'

# Provides the ability to clone a repository to a standard location and
# provide access to that repository.
class Repository
  class << self
    def clone(repositories_path, pull_request, build_id)
      repo = Rugged::Repository.clone_at(
        pull_request.clone_url,
        clone_directory(repositories_path, pull_request.slug, build_id),
        checkout_branch: pull_request.branch
      )

      yield (repository = new(repo, pull_request.owner, pull_request.repo))

      repository.destroy!
    end

  private

    def clone_directory(repositories_path, slug, build_id)
      File.join(repositories_path, slug, build_id.to_s)
    end
  end

  attr_reader :owner, :name

  def initialize(repo, owner, name)
    @repo = repo
    @owner = owner
    @name = name
  end

  def modified_files(pull_request)
    diff = repo.diff(pull_request.base_sha, pull_request.head_sha)

    changed_patches = diff.patches.select do |patch|
      patch.added? || patch.modified?
    end

    changed_patches.map{|patch| ModifiedFile.new(patch)}
  end

  def branch
    repo.head.name.sub('refs/heads/', '')
  end

  def local_path
    repo.path.sub('/.git/', '')
  end

  def destroy!
    FileUtils.rm_rf(local_path)
  end

private

  attr_reader :repo
end
