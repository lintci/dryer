class AnalysisSerializer < ActiveModel::Serializer
  has_many :source_files, serializer: SourceFileSerializer
  attributes :task_id
end
