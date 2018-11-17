require 'finacle_api/common/serializable_object' 
require 'finacle_api/models/dealer'

module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class DisbDealerCode < SerializableObject
        attr_accessor :dsa_id, :dsa_name

        def to_dealer
          Dealer.new(code: dsa_id, dsa_name: dsa_name)
        end

      end
    end
  end
end
