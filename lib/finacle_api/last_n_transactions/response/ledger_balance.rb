require 'finacle_api/common/serializable_object' 
module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class LedgerBalance < SerializableObject
        attr_accessor :amount_value, :currency_code

      end
    end
  end
end
