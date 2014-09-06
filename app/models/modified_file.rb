# Tracks modified file information like line changes and file language
class ModifiedFile
  attr_reader :name, :path
  alias_method :name, :to_s

  def initialize(patch, repository_path)
    @name = patch.delta.new_file[:path]
    @modified_lines = modified_lines_for(patch)
    @path = File.join(repository_path, name)
  end

  def linters
    language.linters
  end

  def language
    Language.for(file_blob)
  end

  def line_modified?(line)
    @modified_lines[line]
  end

  def modified_lines
    @modified_lines.keys
  end

private

  def file_blob
    Linguist::FileBlob.new(path)
  end

  def modified_lines_for(patch)
    lines = patch.hunks.map{|hunk| hunk.lines}.flatten

    lines.select{|line| line.addition?}.map{|line| [line.new_lineno, true]}.to_h
  end
end
