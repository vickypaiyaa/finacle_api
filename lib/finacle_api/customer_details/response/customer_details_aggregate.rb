require 'finacle_api/common/serializable_object'
require 'finacle_api/customer_details/response/ret_cust_inq_response'
require 'finacle_api/customer_details/response/ret_cust_acct_inq_response'

require 'finacle_api/models/customer'

module FinacleApi
  module CustomerDetails
    module ResponseEntity
      class CustomerDetailsAggregate < SerializableObject
        attr_accessor :ret_cust_inq_response, :ret_cust_acct_inq_response
        def initialize(options={})
          options ||= {}
          @ret_cust_inq_response = RetCustInqResponse.new(options.delete(:ret_cust_inq_response))
          @ret_cust_acct_inq_response = RetCustAcctInqResponse.new(options.delete(:ret_cust_acct_inq_response))
        end

        def to_customer
          Customer.new.tap do |c|
            if ret_cust_inq_response.try(:ret_cust_inq_rs).try(:ret_cust_dtls)
              cust_data = ret_cust_inq_response.ret_cust_inq_rs.ret_cust_dtls
              c.first_name = cust_data.first_name
              c.middle_name = cust_data.middle_name
              c.last_name = cust_data.last_name
              c.birth_dt = cust_data.birth_dt.split("T").try(:first)
              c.crn = cust_data.cust_id
              c.pan = cust_data.pan
              c.cust_type = cust_data.cust_type
              c.segment = cust_data.segmentation_class
              c.sub_segment = cust_data.sub_segment
              c.gender_code = cust_data.gender
              c.start_date = cust_data.relationship_opening_dt.split("T").try(:first)
              c.status = cust_data.status
              c.cust_type_code = cust_data.cust_type_code
              if cust_data.ret_cust_addr_infos
                cust_data.ret_cust_addr_infos.each do |addr|
                  c.addresses << addr.to_address
                end
              end
              if cust_data.phone_email_infos
                cust_data.phone_email_infos.each do |contact|
                  c.contact_info << contact.to_contact_info
                end
              end
              if ret_cust_inq_response.try(:ret_cust_inq_rs).try(:demographic_dtls)
                c.nationality = ret_cust_inq_response.ret_cust_inq_rs.demographic_dtls.nationality
              end
            end
            if ret_cust_acct_inq_response.try(:ret_cust_acct_inq_rs).try(:ret_sale_dtls)
              accounts = ret_cust_acct_inq_response.ret_cust_acct_inq_rs.ret_sale_dtls
              accounts.each do |acct|
                c.accounts << acct.to_account
              end
            end
          end
        end # def

      end #class

    end
  end
end