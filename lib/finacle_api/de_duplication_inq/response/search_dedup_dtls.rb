require 'finacle_api/common/serializable_object'
require 'finacle_api/models/customer'
require 'finacle_api/models/address'

module FinacleApi
  module DeDuplicationInq
    module ResponseEntity
      class SearchDedupDtls < SerializableObject
        attr_accessor :search_dedup_data

        def initialize(options={})
          options ||= {}
          @search_dedup_data = SearchDedupData.new(options.delete(:search_dedup_data))
        end

        def to_customer
          Customer.new.tap do |c|
            if search_dedup_data
              cust_data = search_dedup_data
              c.first_name = cust_data.first_name
              c.middle_name = cust_data.middle_name
              c.last_name = cust_data.last_name
              c.birth_dt = cust_data.birth_dt.split("T").try(:first)
              c.addresses = []
              c.addresses << Address.new(
                addr_line1: cust_data.addr_line1,
                addr_line2: cust_data.addr_line2,
                addr_line3: cust_data.addr_line3
              )
              c.crn = cust_data.cust_id
              c.cust_type = cust_data.cust_type
            end
          end
        end

      end
    end
  end
end