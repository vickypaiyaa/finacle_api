require 'finacle_api/common/serializable_object'
module FinacleApi

  class Amount < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :value, :currency

    def in_full
      "#{value} #{currency}"
    end

  end

end