require 'lint_trap'

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
    LintTrap::Language.find(file_blob.language.name)
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
    "<ModifiedFile: #{name} #{modified_lines.map(&:to_i).inspect}>"
  end

private

  def file_blob
    Linguist::FileBlob.new(path)
  end

  def modified_lines_for(patch)
    lines = patch.hunks.map(&:lines).flatten

    lines.select(&:addition?).map{|line| [line.new_lineno.to_s, true]}.to_h
  end
end
