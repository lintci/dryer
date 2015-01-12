require 'lint_trap'

# Tracks modified file information like line changes and file language
class ModifiedFile
  attr_reader :name, :path, :lines

  delegate :linters, to: :language

  def initialize(workdir, name, lines)
    @name = name
    @lines = lines
    @path = File.join(workdir, name)
  end

  def language
    @language ||= LintTrap::Language.detect(path)
  end

  def ==(other)
    name == other.name &&
      lines == other.lines &&
      path == other.path
  end

  def to_s
    name
  end

  def inspect
    "<ModifiedFile: #{path} #{lines.inspect}>"
  end

private

  def file_blob
    Linguist::FileBlob.new(path)
  end
end
