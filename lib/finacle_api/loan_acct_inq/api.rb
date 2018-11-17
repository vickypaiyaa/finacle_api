require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/loan_acct_inq/request'
require 'finacle_api/loan_acct_inq/response/loan_acct_inq_response'

require 'finacle_api/utils/account_utils'

module FinacleApi
  module LoanAcctInq
    module API
      include FinacleApi::Utils
      include FinacleApi::Common

      def loan_account_details(acct_id, options={})
        req = FinacleApi::LoanAcctInq::Request.new(:acct_id => acct_id, :security_hash => send(:security_hash))
        response_body = response_from(:post, FinacleApi::LoanAcctInq::Request::API_PATH, req.xml_payload)["FIXML"]["Body"]
        p "response body is #{response_body.inspect}"
        body_hash = convert_hash_keys(response_body)
        loan_acct_inq_response_object(body_hash)
        # loan_acct_umarshal(body_hash)
      end

      def loan_acct_umarshal(hash)
        p "LAA hash is #{hash.inspect}"
        if hash.has_key?(:error)
          error_object(hash)
        else
          FinacleApi::LoanAcctInq::ResponseEntity::LoanAcctInqResponse.new(hash.delete(:loan_acct_inq_response))
        end
      end

      def loan_acct_inq_response_object(hash)
        mobject = loan_acct_umarshal(hash)
        FinacleApi::Utils::AccountUtils.build_loan_account(mobject)
      end



    end
  end
end