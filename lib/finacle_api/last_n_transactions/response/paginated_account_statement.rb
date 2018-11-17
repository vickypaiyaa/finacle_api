require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/response/account_balances' 
require 'finacle_api/last_n_transactions/response/transaction_details' 
module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class PaginatedAccountStatement < SerializableObject
        attr_accessor :account_balances, :field125, :field126, :field127, :has_more_data, :transaction_details

        def initialize(options={})
          options ||= {}
          @account_balances = AccountBalances.new(options.delete(:account_balances))
          transaction_details = options.delete(:transaction_details)

          if transaction_details 
            if transaction_details.is_a?(Array)
              @transaction_details = transaction_details.map { |result| TransactionDetails.new(result) }
            else
              @transaction_details = [TransactionDetails.new(transaction_details)]
            end
          end

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_statement
          transactions = []
          if transaction_details && transaction_details.is_a?(Array)
            transaction_details.each do |t|
              transactions.push(t.to_transaction)
            end
          end
          transactions
        end

      end
    end
  end
end
