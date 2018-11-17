require 'finacle_api/common/serializable_object' 
module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class ValueInAmt < SerializableObject
        attr_accessor :amount_value, :currency_code

        def to_amount
          Amount.new(value: amount_value, currency: currency_code)
        end

      end
    end
  end
end
