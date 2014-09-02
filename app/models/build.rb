class Build
  attr_reader :id, :payload

  def initialize(id, data)
    @id = id
    @payload = Payload.new(data)
  end

  def run
    clone_repository do |repo|
      files = repo.modified_files.group_by{|file| file.linters}
      linters = linters_for(files)
      linters.each do |linter|
        linter.lint
      end
    end
  end

private

  def clone_repository
    return unless payload.pull_request?

    Repository.clone(repositories_path, payload.pull_request, id, &Proc.new)
  end

  def repositories_path
    Rails.root.join('tmp')
  end
end
