require 'lint_trap'

# Tracks modified file information like line changes and file language
class SourceFile
  include ActiveModel::Model

  ATTRIBUTES = :name, :sha, :workdir, :modified_lines, :language, :size, :extension,
               :binary, :generated, :vendored, :documentation, :image

  attr_accessor(*ATTRIBUTES)

  class << self
    def build(workdir, name, sha, lines)
      path = File.join(workdir, name)
      language = LintTrap::Language.detect(path)
      blob = Linguist::FileBlob.new(path)

      new(
        workdir: workdir,
        name: name,
        sha: sha,
        modified_lines: lines,
        language: language,
        extension: blob.extension,
        size: blob.size,
        binary: blob.binary? || false,
        generated: blob.generated? || false,
        vendored: blob.vendored? || false,
        documentation: blob.documentation? || false,
        image: blob.image? || false
      )
    end
  end

  def source_type
    if language
      language.name
    elsif image?
      extension[1..-1].upcase
    elsif documentation?
      'Documentation'
    elsif binary?
      'Binary'
    end
  end

  def linters
    return [] unless language

    language.linters
  end

  def path
    File.join(workdir, name)
  end

  def ==(other)
    ATTRIBUTES.all?{|attribue| send(attribue) == other.send(attribue)}
  end

  def to_s
    name
  end

  def inspect
    "<SourceFile: #{name} sha=#{sha[0...6]} type=#{source_type} size=#{formatted_size} modified_lines=#{modified_lines.inspect}"\
    " binary=#{binary} generated=#{generated} vendored=#{vendored} documentation=#{documentation} image=#{image}>"
  end

  def read_attribute_for_serialization(name)
    public_send(name)
  end

private

  def formatted_size
    ActiveSupport::NumberHelper::NumberToHumanSizeConverter.convert(size, {})
  end
end

# t.string :source_type, null: false
#       t.boolean :generated
#       t.boolean :vendored
#       t.boolean :documentation
#       t.boolean :binary
#       t.integer :size
