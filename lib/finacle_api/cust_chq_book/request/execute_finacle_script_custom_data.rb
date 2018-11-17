require 'finacle_api/common/serializable_object' 
module FinacleApi
  module CustChqBook
    module RequestEntity
      class ExecuteFinacleScriptCustomData < SerializableObject
        attr_accessor :account_id, :cheque_type

      end
    end
  end
end
