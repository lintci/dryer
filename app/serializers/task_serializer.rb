# Serializes a task
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :type, :language, :tool
end
