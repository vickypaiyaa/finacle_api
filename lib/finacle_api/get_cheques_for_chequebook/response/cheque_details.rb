require 'finacle_api/common/serializable_object' 
module FinacleApi
  module GetChequesForChequebook
    module ResponseEntity
      class ChequeDetails < SerializableObject
        attr_accessor :acid, :branch_id, :cheque_number, :cheque_status

      end
    end
  end
end
