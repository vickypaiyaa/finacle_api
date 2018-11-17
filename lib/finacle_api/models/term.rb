require 'finacle_api/common/serializable_object'
module FinacleApi

  class Term < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :days, :months

    def in_full
      "#{months} months #{days} days"
    end

  end
end