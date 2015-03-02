class ClassificationSerializer < ActiveModel::Serializer
  class ModifiedFileSerializer < ActiveModel::Serializer
    attributes :name, :lines
  end

  class GroupSerializer < ActiveModel::Serializer
    has_many :modified_files, serializer: ModifiedFileSerializer
    attributes :linter, :language

    def linter
      object.linter.name
    end

    def language
      object.language.name
    end
  end

  has_many :groups, serializer: GroupSerializer
  attributes :task_id
end
