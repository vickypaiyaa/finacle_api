require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/request/paginated_account_transaction_list' 
module FinacleApi
  module LastNTransactions
    module RequestEntity
      class getLastNTransactionsWithPaginationRequest < SerializableObject
        attr_accessor :paginated_account_transaction_list

        def initialize(options={})
          @paginated_account_transaction_list = PaginatedAccountTransactionList.new(options.delete(:paginated_account_transaction_list))
        end
      end
    end
  end
end
