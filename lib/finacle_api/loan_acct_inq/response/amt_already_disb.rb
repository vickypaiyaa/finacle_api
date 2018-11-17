require 'finacle_api/common/serializable_object' 
require 'finacle_api/models/amount'
module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class AmtAlreadyDisb < SerializableObject
        attr_accessor :amount_value, :currency_code

        def to_amount
          Amount.new(value: amount_value, currency: currency_code)
        end
      end
    end
  end
end
