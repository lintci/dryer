module Msg
  module V1
    # Serializes a task
    class TaskSerializer < ActiveModel::Serializer
      has_many :source_files, serializer: Msg::V1::SourceFileSerializer

      attributes :type, :status, :language, :tool
    end
  end
end
