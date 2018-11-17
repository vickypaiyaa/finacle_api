require 'finacle_api/common/serializable_object'
require 'finacle_api/de_duplication_inq/response/de_duplication_inq_custom_data'
require 'finacle_api/de_duplication_inq/response/de_duplication_inq_rs'

require 'finacle_api/models/customer_search_result'

module FinacleApi
  module DeDuplicationInq
    module ResponseEntity
      class DeDuplicationInqResponse < SerializableObject
        attr_accessor :de_duplication_inq_rs, :de_duplication_inq_custom_data

        def initialize(options={})
          options ||= {}
          @de_duplication_inq_rs = DeDuplicationInqRs.new(options.delete(:de_duplication_inq_rs))
          @de_duplication_inq_custom_data = DeDuplicationInqCustomData.new(options.delete(:de_duplication_inq_custom_data))
        end

        def to_customer_search_result
          FinacleApi::CustomerSearchResult.new.tap do |sr|
            if de_duplication_inq_rs && de_duplication_inq_rs.search_dedup_dtls.is_a?(Array)
              rs = de_duplication_inq_rs
              rs.search_dedup_dtls.each do |sdd|
                customer = sdd.to_customer
                sr.customers.push(customer)
              end
              if rs.rec_ctrl_out
                if rs.rec_ctrl_out.has_more
                  sr.has_more = (rs.rec_ctrl_out.has_more == 'Y') 
                end
                if rs.rec_ctrl_out.set_num
                  sr.page = rs.rec_ctrl_out.set_num
                end
              end
            end
          end #customer search result
        end #def

      end
    end
  end
end