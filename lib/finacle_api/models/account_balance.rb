require 'finacle_api/common/serializable_object'

module FinacleApi

  class AccountBalance < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :balance_type, :balance_amount

  end # AccountBalance

end