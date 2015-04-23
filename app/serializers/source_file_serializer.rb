# Serializes source files for communicating with laundromat
class SourceFileSerializer < ActiveModel::Serializer
  has_many :violations, serializer: ViolationSerializer

  attributes :name, :sha, :language, :linters, :modified_lines, :source_type, :size, :extension,
             :binary, :generated, :vendored, :documentation, :image

  def language
    object.language.try(:name)
  end

  def linters
    object.linters.map(&:name)
  end
end
