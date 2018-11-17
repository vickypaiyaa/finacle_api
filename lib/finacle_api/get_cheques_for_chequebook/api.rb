require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/get_cheques_for_chequebook/request'
require 'finacle_api/get_cheques_for_chequebook/response/get_cheques_for_chequebook_response'

module FinacleApi
  module GetChequesForChequebook
    module API
      include FinacleApi::Utils
      include FinacleApi::Common

      def get_cheque_details(account_number, begin_cheque_number, account_branch_id, end_cheque_number, options={})
        req = FinacleApi::GetChequesForChequebook::Request.new(
              :security_hash => send(:security_hash),
              :cheque_inquiry_criteria => {
                :acid => account_number,
                :begin_cheque_number => begin_cheque_number, 
                :branch_id => account_branch_id, 
                :end_cheque_number => end_cheque_number
              }
        )

        response_body = response_from(:post, FinacleApi::GetChequesForChequebook::Request::API_PATH, req.xml_payload)["FIXML"]["Body"]
        body_hash = convert_hash_keys(response_body)
        p "response body is #{response_body.inspect}"
        get_cheques_for_chequebook_response_object(body_hash)
      end

      def get_cheques_for_chequebook_response_object(hash)
        if hash.has_key?(:error)
          error_object(hash)
        else
          FinacleApi::GetChequesForChequebook::ResponseEntity::GetChequesForChequebookResponse.new(hash.delete(:get_cheques_for_chequebook_response))
        end
      end

    end #module API
  end
end
