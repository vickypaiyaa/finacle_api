require 'finacle_api/common/serializable_object' 
module FinacleApi
  module CustChqBook
    module RequestEntity
      class ExecuteFinacleScriptInputVO < SerializableObject
        attr_accessor :request_id

      end
    end
  end
end
