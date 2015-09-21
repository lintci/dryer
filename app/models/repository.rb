require 'rugged'
require 'fileutils'
require_relative 'repository/diff'

# Provides the ability to clone a repository to a standard location and
# provide access to that repository.
class Repository
  PASSPRASE = ENV.fetch('SSH_PASSPHRASE')

  class << self
    def clone(repos_dir, task)
      started_at = Time.zone.now
      repo = Rugged::Repository.clone_at(
        task.clone_url,
        File.join(repos_dir, task.slug),
        credentials: credentials(task)
      )
      repo.checkout(task.head_sha, strategy: :force)

      repository = new(repo)
      yield repository, started_at, Time.zone.now if block_given?

      repository
    ensure
      repository.destroy! if block_given?
    end

  private

    def credentials(task)
      Rugged::Credentials::SshKey.new(
        username: 'git',
        publickey: task.ssh_public_key,
        privatekey: task.ssh_private_key,
        passphrase: PASSPRASE
      )
    end
  end

  delegate :workdir, to: :repo

  def initialize(repo)
    @repo = repo
  end

  def diff(base_sha, head_sha)
    Repository::Diff.new(repo, base_sha, head_sha)
  end

  def source_files(base_sha, head_sha)
    diff(base_sha, head_sha).source_files
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
