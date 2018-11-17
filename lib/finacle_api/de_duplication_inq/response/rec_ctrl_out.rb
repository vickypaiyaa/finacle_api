require 'finacle_api/common/serializable_object'

module FinacleApi
  module DeDuplicationInq
    module ResponseEntity
      class RecCtrlOut < SerializableObject
        attr_accessor :has_more, :set_num
      end
    end
  end
end