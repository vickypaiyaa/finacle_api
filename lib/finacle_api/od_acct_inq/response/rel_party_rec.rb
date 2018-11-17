require 'finacle_api/common/serializable_object' 
require 'finacle_api/od_acct_inq/response/cust_id' 
require 'finacle_api/od_acct_inq/response/rel_party_contact_info' 

require 'finacle_api/models/related_party'
module FinacleApi
  module ODAcctInq
    module ResponseEntity
      class RelPartyRec < SerializableObject
        attr_accessor :rel_party_type, :rel_party_type_desc, :rel_party_code, :rel_party_code_desc, :cust_id, 
                      :rel_party_contact_info, :rec_del_flg

        def initialize(options={})
          options ||= {}
          @cust_id = CustId.new(options.delete(:cust_id))
          @rel_party_contact_info = RelPartyContactInfo.new(options.delete(:rel_party_contact_info))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_related_party
          RelatedParty.new.tap do |p|
            p.type = rel_party_type
            p.desc = rel_party_type_desc
            p.code = rel_party_code
            p.code_desc = rel_party_code_desc
            p.del_flag = rec_del_flg
            if cust_id
              p.customer = cust_id.to_customer
            end

            if rel_party_contact_info
              p.contact_infos = rel_party_contact_info.to_contact_infos
              if rel_party_contact_info.post_addr
                p.address = rel_party_contact_info.post_addr.to_address
              end
            end
          end
        end #def


      end
    end
  end
end
