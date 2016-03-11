module Msg
  module V1
    # Serializes source files for communicating with laundromat
    class SourceFileSerializer < ActiveModel::Serializer
      has_many :violations, serializer: Msg::V1::ViolationSerializer

      attributes :id, :name, :sha, :language, :linters, :modified_lines, :source_type, :size, :extension,
                 :binary, :generated, :vendored, :documentation, :image
    end
  end
end
