# Serializes source files for communicating with laundromat
class SourceFileSerializer < ActiveModel::Serializer
  has_many :violations, serializer: ViolationSerializer

  attributes :id, :name, :sha, :language, :linters, :modified_lines, :source_type, :size, :extension,
             :binary, :generated, :vendored, :documentation, :image


  def include_id?
    object.id
  end
end
