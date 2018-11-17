require 'finacle_api/common/serializable_object' 
require 'finacle_api/td_acct_inq/response/person_name' 
module FinacleApi
  module TDAcctInq
    module ResponseEntity
      class CustId < SerializableObject
        attr_accessor :cust_id, :person_name

        def initialize(options={})
          options ||= {}
          @person_name = PersonName.new(options.delete(:person_name))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_customer
          Customer.new.tap do |c|
            c.crn = cust_id
            if person_name
              c.first_name = person_name.first_name
              c.last_name = person_name.last_name
              c.middle_name = person_name.last_name
              c.name = person_name.name
              c.title_prefix = person_name.title_prefix
            end
          end#customer.new
        end # to_customer

      end
    end
  end
end
