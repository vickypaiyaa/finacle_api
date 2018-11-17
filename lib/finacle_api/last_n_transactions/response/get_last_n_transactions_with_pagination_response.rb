require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/response/paginated_account_statement' 
require 'finacle_api/last_n_transactions/response/get_last_n_transactions_with_pagination_custom_data' 
module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class GetLastNTransactionsWithPaginationResponse < SerializableObject
        attr_accessor :paginated_account_statement, :get_last_n_transactions_with_pagination_custom_data

        def initialize(options={})
          options ||= {}
          @paginated_account_statement = PaginatedAccountStatement.new(options.delete(:paginated_account_statement))
          @get_last_n_transactions_with_pagination_custom_data = GetLastNTransactionsWithPaginationCustomData.new(options.delete(:get_last_n_transactions_with_pagination_custom_data))
        end

        def to_latest_transactions
          if paginated_account_statement
            paginated_account_statement.to_statement
          else
            return []
          end
        end

      end
    end
  end
end
