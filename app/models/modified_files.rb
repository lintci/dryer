# Manages a list of modified files
class ModifiedFiles
  def initialize(diff, path)
    changed_patches = diff.patches.reject do |patch|
      patch.delta.deleted?
    end

    @files = changed_patches.map do |patch|
      file = ModifiedFile.new(patch, path)
      [file.name, file]
    end.to_h
  end

  def grouped_by_linter
    if block_given?
      group_by_linters.each(&Proc.new)
    else
      group_by_linters.each
    end
  end

  def [](name)
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
