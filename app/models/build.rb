class Build
  attr_reader :id, :payload

  def initialize(id, payload)
    @id = id
    @payload = Payload.new(payload)
  end

  def run
    clone_repository do |repo|
      diff = repo.diff(payload.head_sha, payload.base_sha)
      files = diff.modified_files
      linters = linters_for(files)
      linters.each do |linter|
        linter.lint
      end
    end
  end

private

  def clone_repository
    Repository.clone(repositories_path, payload, id, &Proc.new)
  end

  def repositories_path
    Rails.root.join('tmp')
  end
end
