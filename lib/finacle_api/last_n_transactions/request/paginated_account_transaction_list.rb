require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/request/account_list_element' 
module FinacleApi
  module LastNTransactions
    module RequestEntity
      class PaginatedAccountTransactionList < SerializableObject
        attr_accessor :account_list_element, :last_n_transactions

        def initialize(options={})
          options ||= {}
          @account_list_element = AccountListElement.new(options.delete(:account_list_element))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end
      end
    end
  end
end
