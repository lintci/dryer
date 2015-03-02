require 'lint_trap'

# Tracks modified file information like line changes and file language
class ModifiedFile
  attr_reader :name, :path, :lines, :language

  class << self
    def build(workdir, name, lines)
      language = LintTrap::Language.detect(File.join(workdir, name))

      new(workdir, name, lines, language)
    end
  end

  def initialize(workdir, name, lines, language)
    @name = name
    @lines = lines
    @path = File.join(workdir, name)
    @language = language
  end

  def linters
    return [] unless language

    language.linters
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

  def read_attribute_for_serialization(name)
    public_send(name)
  end

private

  def file_blob
    Linguist::FileBlob.new(path)
  end
end
