require 'finacle_api/common/serializable_object' 
module FinacleApi
  module LastNTransactions
    module RequestEntity
      class AccountListElement < SerializableObject
        attr_accessor :acid, :branch_id

      end
    end
  end
end
