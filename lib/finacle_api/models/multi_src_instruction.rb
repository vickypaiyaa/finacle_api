require 'finacle_api/common/serializable_object'
module FinacleApi

  class MultiSrcInstruction < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :installment_type, :repayment_method, :amount_percent_indicator, :value_percent
    attr_accessor :value_amount
    attr_accessor :account_id, :account_currency, :recovery_account_id, :recovery_account_currency

  end
end