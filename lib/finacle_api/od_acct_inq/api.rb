require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/od_acct_inq/request'
require 'finacle_api/od_acct_inq/response/od_acct_inq_response'
require 'finacle_api/utils/account_utils'

module FinacleApi
  module ODAcctInq
    module API
      include FinacleApi::Utils
      include FinacleApi::Common

      def od_account_details(acct_id, options={})
        req = FinacleApi::ODAcctInq::Request.new(:acct_id => acct_id, :security_hash => send(:security_hash),)
        response_body = response_from(:post, FinacleApi::ODAcctInq::Request::API_PATH, req.xml_payload)["FIXML"]["Body"]
        body_hash = convert_hash_keys(response_body)
        od_acct_inq_response_object(body_hash)
        # od_acct_unmarshal(body_hash)
      end

      def od_acct_unmarshal(hash)
        p "ODA hash is #{hash.inspect}"
        if hash.has_key?(:error)
          error_object(hash)
        else
          FinacleApi::ODAcctInq::ResponseEntity::ODAcctInqResponse.new(hash.delete(:od_acct_inq_response))
        end
      end

      def od_acct_inq_response_object(hash)
        mobject = od_acct_unmarshal(hash)
        FinacleApi::Utils::AccountUtils.build_od_account(mobject)
      end

    end
  end
end