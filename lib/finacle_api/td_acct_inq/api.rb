require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/td_acct_inq/request'
require 'finacle_api/td_acct_inq/response/td_acct_inq_response'

require 'finacle_api/utils/account_utils'

module FinacleApi
  module TDAcctInq
    module API
      include FinacleApi::Utils
      include FinacleApi::Common

      def td_account_details(acct_id, options={})
        req = FinacleApi::TDAcctInq::Request.new(:acct_id => acct_id, :security_hash => send(:security_hash),)
        response_body = response_from(:post, FinacleApi::TDAcctInq::Request::API_PATH, req.xml_payload)["FIXML"]["Body"]
        p "response body is #{response_body.inspect}"
        body_hash = convert_hash_keys(response_body)
        td_acct_inq_response_object(body_hash)
        # td_acct_umarshal(body_hash)
      end

      def td_acct_umarshal(hash)
        p "TDA hash is #{hash.inspect}"
        if hash.has_key?(:error)
          error_object(hash)
        else
          FinacleApi::TDAcctInq::ResponseEntity::TDAcctInqResponse.new(hash.delete(:td_acct_inq_response))
        end
      end

      def td_acct_inq_response_object(hash)
        mobject = td_acct_umarshal(hash)
        FinacleApi::Utils::AccountUtils.build_td_account(mobject)
      end


    end
  end
end