require 'finacle_api/common/serializable_object' 
require 'finacle_api/cust_chq_book/response/execute_finacle_script_custom_data' 
module FinacleApi
  module CustChqBook
    module ResponseEntity
      class ExecuteFinacleScriptResponse < SerializableObject
        attr_accessor :execute_finacle_script_output_vo, :execute_finacle_script_custom_data

        def initialize(options={})
          options ||= {}
          @execute_finacle_script_custom_data = ExecuteFinacleScriptCustomData.new(options.delete(:execute_finacle_script_custom_data))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end
      end
    end
  end
end
