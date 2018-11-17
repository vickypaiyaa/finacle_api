require 'finacle_api/exception/api_exception'

module FinacleApi
  module Utils
    module CustomerUtils

      def self.build_customer_search_result(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::DeDuplicationInq::ResponseEntity::DeDuplicationInqResponse
          response.to_customer_search_result
        else
          []
        end
      end #def

      def self.build_customer(response)
        raise  FinacleApi::Exception::APIException.new(response.full_messages) if response.is_error?
        if response.is_a? FinacleApi::CustomerDetails::ResponseEntity::CustomerDetailsAggregate
          response.to_customer
        end
      end # def

    end
  end
end
