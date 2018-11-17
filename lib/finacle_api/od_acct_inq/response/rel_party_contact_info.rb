require 'finacle_api/common/serializable_object' 
require 'finacle_api/od_acct_inq/response/phone_num' 
require 'finacle_api/od_acct_inq/response/post_addr' 
require 'finacle_api/models/contact_info'
module FinacleApi
  module ODAcctInq
    module ResponseEntity
      class RelPartyContactInfo < SerializableObject
        attr_accessor :phone_num, :email_addr, :post_addr

        def initialize(options={})
          options ||= {}
          @phone_num = PhoneNum.new(options.delete(:phone_num))
          @post_addr = PostAddr.new(options.delete(:post_addr))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_contact_infos
          cinfos = []
          cinfos.push(ContactInfo.new(value: email_addr, category: 'EMAIL'))
          if phone_num && phone_num.telephone_num
            cinfos.push(ContactInfo.new(value: phone_num.telephone_num, category: 'PHONE'))
          end
          if phone_num && phone_num.fax_num
            cinfos.push(ContactInfo.new(value: phone_num.fax_num, category: 'FAX'))
          end
          if phone_num && phone_num.telex_num
            cinfos.push(ContactInfo.new(value: phone_num.telex_num, category: 'TELEX'))
          end
          cinfos
        end

      end
    end
  end
end
