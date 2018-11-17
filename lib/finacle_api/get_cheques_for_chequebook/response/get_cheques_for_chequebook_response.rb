require 'finacle_api/common/serializable_object' 
require 'finacle_api/get_cheques_for_chequebook/response/cheque_inquiry_response_vo' 
require 'finacle_api/get_cheques_for_chequebook/response/get_cheques_for_chequebook_custom_data' 
module FinacleApi
  module GetChequesForChequebook
    module ResponseEntity
      class GetChequesForChequebookResponse < SerializableObject
        attr_accessor :cheque_inquiry_response_vo, :get_cheques_for_chequebook_custom_data

        def initialize(options={})
          options ||={}
          @cheque_inquiry_response_vo = ChequeInquiryResponseVO.new(options.delete(:cheque_inquiry_response_vo))
          @get_cheques_for_chequebook_custom_data = GetChequesForChequebookCustomData.new(options.delete(:get_cheques_for_chequebook_custom_data))
        end
      end
    end
  end
end
