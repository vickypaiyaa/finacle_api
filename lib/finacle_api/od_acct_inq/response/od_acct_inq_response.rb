require 'finacle_api/common/serializable_object' 
require 'finacle_api/od_acct_inq/response/od_acct_inq_rs' 



module FinacleApi
  module ODAcctInq
    module ResponseEntity

      class ODAcctInqResponse < SerializableObject
        attr_accessor :od_acct_inq_rs, :od_acct_inq_custom_data

        def initialize(options={})
          options ||= {}
          @od_acct_inq_rs = ODAcctInqRs.new(options.delete(:od_acct_inq_rs))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_od_account
          oda = nil
          if od_acct_inq_rs && od_acct_inq_rs.od_acct_inq
            oda = od_acct_inq_rs.od_acct_inq.to_account
          end

          if oda && od_acct_inq_rs.try(:od_acct_gen_info)
            general_info = od_acct_inq_rs.try(:od_acct_gen_info)
            if general_info.gen_ledger_sub_head
              oda.gl_code = general_info.gen_ledger_sub_head.gen_ledger_sub_head_code
              oda.gl_currency = general_info.gen_ledger_sub_head.cur_code
            end
            oda.acct_name = general_info.acct_name
            oda.acct_short_name = general_info.acct_short_name
          end

          if oda && od_acct_inq_rs.acct_bal_amt
            bal = od_acct_inq_rs.acct_bal_amt
            oda.account_balance = bal.to_amount
          end
          if od_acct_inq_rs
            oda.opening_date = od_acct_inq_rs.acct_opn_dt
            oda.mode_of_operation = od_acct_inq_rs.mode_of_oper
            oda.status = od_acct_inq_rs.bank_acct_status_code
            oda.customer = od_acct_inq_rs.cust_id.to_customer
            oda.freeze_status = od_acct_inq_rs.freeze_status_code
            oda.interest_rate_code = od_acct_inq_rs.int_rate_code

            if od_acct_inq_rs.accr_int_rate
              oda.accrual_interest_rate = od_acct_inq_rs.accr_int_rate.value
            end

            if od_acct_inq_rs.net_int_rate
              oda.net_interest_rate = od_acct_inq_rs.net_int_rate.value
            end
            if od_acct_inq_rs.int_calc_freq
              freq_data = od_acct_inq_rs.int_calc_freq
              oda.interest_calc_frequency = freq_data.to_frequency
            end

            if od_acct_inq_rs.rel_party_recs
              od_acct_inq_rs.rel_party_recs.each do |party|
                oda.related_parties.push(party.to_related_party)
              end
            end
          end

          return oda
        end

      end #class


    end
  end
end
