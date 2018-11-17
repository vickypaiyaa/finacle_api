require 'finacle_api/common/serializable_object'
require 'finacle_api/models/contact_info'

module FinacleApi
  module CustomerDetails
    module ResponseEntity
      class PhoneEmailInfo < SerializableObject
        attr_accessor :phone_email_info, :email_palm, :phone_email_type, :phone_num, :phone_num_city_code, 
          :phone_num_country_code, :phone_num_local_code, :phone_or_email, :pref_flag, :work_extn_num

        def to_contact_info
          value = phone_num unless (phone_num.nil? || phone_num.empty?)
          value = email_palm unless (email_palm.nil? || email_palm.empty?)
          ContactInfo.new(value: value, sub_category: phone_email_type,
                          category: phone_or_email, preferred: (pref_flag == 'Y'? true : false) )
        end
      end
    end
  end
end