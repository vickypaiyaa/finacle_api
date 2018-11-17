require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/last_n_transactions/request'
require 'finacle_api/last_n_transactions/response/get_last_n_transactions_with_pagination_response'
require 'finacle_api/utils/account_utils'
module FinacleApi
  module LastNTransactions
    module API
      include FinacleApi::Utils
      include FinacleApi::Common

      def transactions(account_number, branch_id, number_of_transactions)
        req = FinacleApi::LastNTransactions::Request.new(
                  :security_hash => send(:security_hash), 
                  :number_of_transactions => "#{number_of_transactions||5}",
                  :account_list_element => {
                    :acid => account_number,
                    :branch_id => branch_id
                  }
        )
        response_body = response_from(:post, FinacleApi::LastNTransactions::Request::API_PATH, req.xml_payload)["FIXML"]["Body"]
        body_hash = convert_hash_keys(response_body)
        last_n_transactions_response_object(body_hash)
      end

      def last_n_transactions_unmarshal(hash)
        if hash.has_key?(:error)
          error_object(hash)
        else
          FinacleApi::LastNTransactions::ResponseEntity::GetLastNTransactionsWithPaginationResponse.new(hash.delete(:get_last_n_transactions_with_pagination_response))
        end
      end

      def last_n_transactions_response_object(hash)
        mobject = last_n_transactions_unmarshal(hash)
        FinacleApi::Utils::AccountUtils.build_transactions(mobject)
      end

    end #API 
  end
end
