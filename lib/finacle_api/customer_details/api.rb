require 'finacle_api/utils'
require 'finacle_api/common'
require 'finacle_api/customer_details/request'
require 'finacle_api/customer_details/response/customer_details_aggregate'

require 'finacle_api/utils/customer_utils'

module FinacleApi
  module CustomerDetails
    module API
      include FinacleApi::Utils
      include FinacleApi::Common
      def customer_details(cust_id, options={})
        cust_type = options.delete(:cust_type) || 'Retail'
        req = FinacleApi::CustomerDetails::Request.new(:cust_id => "#{cust_id}", :cust_type => cust_type)
        response_body = response_from(:get, FinacleApi::CustomerDetails::Request::API_PATH, req.params)["FIXML"]["Body"]
        body_hash = convert_hash_keys(response_body)
        #unmarshal(body_hash)
        customer_details_response_object(body_hash)
      end

      def cust_details_unmarshal(hash)
        # p "response body hash ~> [#{hash.inspect}]"
        if hash.has_key?(:error)
          error_object(hash)
        else 
          cust_aggregate = hash.delete(:customer_details_aggregate)
          if cust_aggregate.has_key?(:error) 
            error_object(cust_aggregate)
          else
            FinacleApi::CustomerDetails::ResponseEntity::CustomerDetailsAggregate.new(cust_aggregate)
          end
        end
      end

      def customer_details_response_object(hash)
        mobject = cust_details_unmarshal(hash)
        p "mobj is #{mobject.inspect}"
        FinacleApi::Utils::CustomerUtils.build_customer(mobject)
      end
    end
  end
end