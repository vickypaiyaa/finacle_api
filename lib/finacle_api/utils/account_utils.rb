require 'finacle_api/exception/api_exception'

module FinacleApi
  module Utils
    module AccountUtils

      def self.build_od_account(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::ODAcctInq::ResponseEntity::ODAcctInqResponse
          response.to_od_account
        end
      end #def

      def self.build_td_account(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::TDAcctInq::ResponseEntity::TDAcctInqResponse
          response.to_td_account
        end
      end #def

      def self.build_loan_account(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::LoanAcctInq::ResponseEntity::LoanAcctInqResponse
          response.to_loan_account
        end
      end #def

      def self.build_balances(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::BalInq::ResponseEntity::BalInqResponse
          response.to_balances
        end
      end

      def self.build_transactions(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::LastNTransactions::ResponseEntity::GetLastNTransactionsWithPaginationResponse
          response.to_latest_transactions
        end
      end

    end
  end
end
