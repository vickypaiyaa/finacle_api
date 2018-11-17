require 'finacle_api/common/serializable_object'
module FinacleApi

  class Dealer < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :code, :name

  end
end