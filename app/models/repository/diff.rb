class Repository
  class Diff
    def initialize(repo, base_sha, head_sha)
      @repo = repo
      @base_sha = base_sha
      @head_sha = head_sha
    end

    def modified_files
      changed_patches.map do |patch|
        ModifiedFile.build(repo.workdir, file_name(patch), lines(patch))
      end
    end

  protected

    attr_reader :repo, :base_sha, :head_sha

  private

    def diff
      repo.diff(base_sha, head_sha)
    end

    def changed_patches
      diff.patches.reject{|patch| patch.delta.deleted?}
    end

    def file_name(patch)
      patch.delta.new_file[:path]
    end

    def lines(patch)
      patch.hunks.map(&:lines)
                 .flatten
                 .select(&:addition?)
                 .map(&:new_lineno)
    end
  end
end
