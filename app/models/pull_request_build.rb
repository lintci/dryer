# Lints a pull request
class PullRequestBuild
  attr_reader :id, :pull_request

  def initialize(id, pull_request)
    @id = id
    @pull_request = pull_request
  end

  def run
    clone_repository do |repo|
      files = repo.modified_files(pull_request)

      files.grouped_by_linter do |linter, modified_files|
        LintWorker.new(linter, modified_files, Subscription.new)
      end
    end
  end

  def inspect
    "<Build: ##{id} #{pull_request.slug}>"
  end

private

  def clone_repository
    Repository.clone(repositories_path, pull_request, id, &Proc.new)
  end

  def repositories_path
    Rails.root.join('tmp')
  end
end
