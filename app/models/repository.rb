require 'rugged'
require 'fileutils'

class Repository
  class << self
    def clone(repositories_path, payload, build_id)
      repo = Rugged::Repository.clone_at(
        payload.clone_url,
        clone_directory(repositories_path, payload, build_id),
        checkout_branch: payload.branch
      )

      yield (repository = new(repo, payload.owner, payload.repo))

      repository.destroy!
    end

  private

    def clone_directory(repositories_path, payload, build_id)
      File.join(
        repositories_path,
        payload.owner,
        payload.repo,
        payload.branch,
        build_id.to_s
      )
    end
  end

  attr_reader :owner, :name

  def initialize(repo, owner, name)
    @repo = repo
    @owner = owner
    @name = name
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
