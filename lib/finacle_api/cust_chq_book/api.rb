require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/cust_chq_book/request'
require 'finacle_api/cust_chq_book/response/execute_finacle_script_response'

module FinacleApi
  module CustChqBook
    module API
      include FinacleApi::Utils
      include FinacleApi::Common

      def cheque_book_request(account_number, cheque_type, options={})
        req = FinacleApi::CustChqBook::Request.new(
              :security_hash => send(:security_hash), 
              :cheque_type => cheque_type,
              :account_number => account_number
        )

        response_body = response_from(:post, FinacleApi::CustChqBook::Request::API_PATH, req.xml_payload)["FIXML"]["Body"]
        body_hash = convert_hash_keys(response_body)
        # p "response body cheque book request #{response_body.inspect}"
        cust_chq_book_response_object(body_hash)
      end

      def cust_chq_book_response_object(hash)
        if hash.has_key?(:error)
          error_object(hash)
        else
          FinacleApi::CustChqBook::ResponseEntity::ExecuteFinacleScriptResponse.new(hash.delete(:execute_finacle_script_response))
        end
      end

    end #API
  end
end
