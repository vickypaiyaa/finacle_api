require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/response/available_balance' 
require 'finacle_api/last_n_transactions/response/f_fd_balance' 
require 'finacle_api/last_n_transactions/response/floating_balance' 
require 'finacle_api/last_n_transactions/response/ledger_balance' 
require 'finacle_api/last_n_transactions/response/user_defined_balance' 
module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class AccountBalances < SerializableObject
        attr_accessor :acid, :available_balance, :branch_id, :currency_code, :f_fd_balance, :floating_balance, :ledger_balance, :user_defined_balance

        def initialize(options={})
          options ||= {}
          @available_balance = AvailableBalance.new(options.delete(:available_balance))
          @f_fd_balance = FFDBalance.new(options.delete(:f_fd_balance))
          @floating_balance = FloatingBalance.new(options.delete(:floating_balance))
          @ledger_balance = LedgerBalance.new(options.delete(:ledger_balance))
          @user_defined_balance = UserDefinedBalance.new(options.delete(:user_defined_balance))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end
      end
    end
  end
end
