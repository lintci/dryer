module Msg
  module V1
    # Serializes violations
    class ViolationSerializer < ActiveModel::Serializer
      attributes :line, :column, :length, :rule, :severity, :message
    end
  end
end
