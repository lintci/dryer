# Serializes the result of linting a group of files
class LintingSerializer < ActiveModel::Serializer
  attributes :task_id, :clean
end
