class ClassificationSerializer < ActiveModel::Serializer
  class SourceFileSerializer < ActiveModel::Serializer
    attributes :name, :language, :linters, :modified_lines, :source_type, :size, :extension,
               :binary, :generated, :vendored, :documentation, :image

    def language
      object.language.try(:name)
    end

    def linters
      object.linters.map(&:name)
    end
  end

  has_many :source_files, serializer: SourceFileSerializer
  attributes :task_id
end
