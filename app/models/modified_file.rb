# Tracks modified file information like line changes and file language
class ModifiedFile
  attr_reader :name, :path

  def initialize(patch, repository_path)
    @name = patch.delta.new_file[:path]
    @modified_lines = modified_lines_for(patch)
    @path = File.join(repository_path, name)
  end

  delegate :linters, to: :language

  def language
    Language.for(file_blob)
  end

  def line_modified?(line)
    @modified_lines[line]
  end

  def modified_lines
    @modified_lines.keys
  end

  def ==(other)
    name == other.name &&
      modified_lines == other.modified_lines &&
      path == other.path
  end

  def to_s
    @name
  end

  def inspect
    "<ModifiedFile: #{name} #{modified_lines.inspect}>"
  end

private

  def file_blob
    Linguist::FileBlob.new(path)
  end

  def modified_lines_for(patch)
    lines = patch.hunks.map(&:lines).flatten

    lines.select(&:addition?).map{|line| [line.new_lineno, true]}.to_h
  end
end
