class ModifiedFiles
  def initialize(diff)
    changed_patches = diff.patches.select do |patch|
      patch.added? || patch.modified?
    end

    @files = changed_patches.map do |patch|
      file = ModifiedFile.new(patch)
      [file.name, file]
    end.to_h
  end

  def each_grouped_by_linter
    group_by_linters.each(&Proc.new)
  end

  def file(name)
    @files[name]
  end

protected

  attr_reader :files

  def group_by_linters
    files.values.each_with_object(Hash.new{|h, k| h[k] = []}) do |file, grouping|
      file.linters.each do |linter|
        grouping[linter] << file
      end
    end
  end
end
