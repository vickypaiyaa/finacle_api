require 'finacle_api/common/serializable_object' 
require 'finacle_api/get_cheques_for_chequebook/response/cheque_details' 
module FinacleApi
  module GetChequesForChequebook
    module ResponseEntity
      class ChequeInquiryResponseVO < SerializableObject
        attr_accessor :cheque_details

        def initialize(options={})
          options ||={}
          cheque_details = options.delete(:cheque_details)
          if cheque_details
            if cheque_details.is_a?(Array)
              @cheque_details = cheque_details.map { |result| ChequeDetails.new(result) }
            else
              @cheque_details = [ChequeDetails.new(cheque_details)]
            end
          end

        end
      end
    end
  end
end
