require 'finacle_api/common/serializable_object' 
require 'finacle_api/models/address'

module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class PostAddr < SerializableObject
        attr_accessor :addr1, :addr2, :addr3, :city, :state_prov, :postal_code, :country, :addr_type

        def to_address
          Address.new(addr_line1: addr1, addr_line2: addr2, addr_line3: addr3, city: city,
                      state: state_prov, postal_code: postal_code, country: country)
        end

      end
    end
  end
end
