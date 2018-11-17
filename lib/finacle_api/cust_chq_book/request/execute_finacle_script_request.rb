require 'finacle_api/common/serializable_object' 
require 'finacle_api/cust_chq_book/request/execute_finacle_script_input_vo' 
require 'finacle_api/cust_chq_book/request/execute_finacle_script_custom_data' 
module FinacleApi
  module CustChqBook
    module RequestEntity
      class ExecuteFinacleScriptRequest < SerializableObject
        attr_accessor :execute_finacle_script_input_vo, :execute_finacle_script_custom_data

        def initialize(options={})
          options ||= {}
          @execute_finacle_script_input_vo = ExecuteFinacleScriptInputVO.new(options.delete(:execute_finacle_script_input_vo))
          @execute_finacle_script_custom_data = ExecuteFinacleScriptCustomData.new(options.delete(:execute_finacle_script_custom_data))
        end
      end
    end
  end
end
