require 'finacle_api/common/serializable_object' 
require 'finacle_api/td_acct_inq/response/renewal_term' 
require 'finacle_api/td_acct_inq/response/renewal_schm' 
require 'finacle_api/td_acct_inq/response/gen_ledger_sub_head' 
require 'finacle_api/td_acct_inq/response/renewal_amt' 
require 'finacle_api/td_acct_inq/response/renewal_addnl_amt' 
require 'finacle_api/td_acct_inq/response/src_acct_id' 

require 'finacle_api/models/renewal_details'
module FinacleApi
  module TDAcctInq
    module ResponseEntity
      class RenewalDtls < SerializableObject
        attr_accessor :auto_close_on_maturity_flg, :auto_renewalflg, :max_num_of_renewal_allwd, :renewal_term, 
                      :renewal_schm, :gen_ledger_sub_head, :int_tbl_code, :renewal_cur_code, :renewal_option, 
                      :renewal_amt, :renewal_addnl_amt, :src_acct_id

        def initialize(options={})
          options ||= {}
          @renewal_term = RenewalTerm.new(options.delete(:renewal_term))
          @renewal_schm = RenewalSchm.new(options.delete(:renewal_schm))
          @gen_ledger_sub_head = GenLedgerSubHead.new(options.delete(:gen_ledger_sub_head))
          @renewal_amt = RenewalAmt.new(options.delete(:renewal_amt))
          @renewal_addnl_amt = RenewalAddnlAmt.new(options.delete(:renewal_addnl_amt))
          @src_acct_id = SrcAcctId.new(options.delete(:src_acct_id))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_renewal_details
          RenewalDetails.new(auto_renewal_flag:auto_renewalflg, 
              auto_close_on_maturity: auto_close_on_maturity_flg, renewal_option: renewal_option).tap do |rd|
            if renewal_schm
              rd.scheme_code = renewal_schm.schm_code
              rd.scheme_type = renewal_schm.schm_type
            end
            if gen_ledger_sub_head
              rd.gl_code = gen_ledger_sub_head.gen_ledger_sub_head_code
              rd.gl_currency = gen_ledger_sub_head.cur_code
            end
            rd.renewal_term = renewal_term.to_term if renewal_term
            rd.renewal_amount = renewal_amt.to_amount if renewal_amt
            rd.renewal_additional_amount = renewal_addnl_amt.to_amount if renewal_addnl_amt
            rd.source_account = src_acct_id.to_account if src_acct_id

          end
        end

      end
    end
  end
end
