require 'finacle_api/common/serializable_object' 
require 'finacle_api/models/term'

module FinacleApi
  module TDAcctInq
    module ResponseEntity
      class DepositTerm < SerializableObject
        attr_accessor :days, :months

        def to_term
          Term.new(days: days, months: months)
        end
      end
    end
  end
end
