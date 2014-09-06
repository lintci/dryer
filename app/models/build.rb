class Build
  attr_reader :id, :pull_request

  def initialize(id, data)
    @id = id
    @pull_request = PullRequest.new(data)
  end

  def run
    clone_repository do |repo|
      files = repo.modified_files(pull_request)

      files.each_grouped_by_linter do |linter, file_group|
        linter.lint(file_group)
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
