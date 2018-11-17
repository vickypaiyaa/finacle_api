require 'finacle_api/common/serializable_object' 
module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class GetLastNTransactionsWithPaginationCustomData < SerializableObject
        attr_accessor :thb

      end
    end
  end
end
