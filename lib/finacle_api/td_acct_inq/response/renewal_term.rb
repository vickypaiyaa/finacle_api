require 'finacle_api/common/serializable_object' 
module FinacleApi
  module TDAcctInq
    module ResponseEntity
      class RenewalTerm < SerializableObject
        attr_accessor :days, :months

        def to_term
          Term.new(days: days, months: months)
        end

      end
    end
  end
end
