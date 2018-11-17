require 'finacle_api/common/serializable_object' 
require 'finacle_api/td_acct_inq/response/td_acct_inq_rs' 
require 'finacle_api/td_acct_inq/response/td_acct_inq_custom_data' 
module FinacleApi
  module TDAcctInq
    module ResponseEntity
      class TDAcctInqResponse < SerializableObject
        attr_accessor :td_acct_inq_rs, :td_acct_inq_custom_data

        def initialize(options={})
          @td_acct_inq_rs = TDAcctInqRs.new(options.delete(:td_acct_inq_rs))
          @td_acct_inq_custom_data = TDAcctInq_CustomData.new(options.delete(:td_acct_inq_custom_data))
        end

        def to_td_account
          account = nil
          if td_acct_inq_rs && td_acct_inq_rs.td_acct_id
            account = td_acct_inq_rs.td_acct_id.to_account
          end

          if account && td_acct_inq_rs.try(:td_acct_gen_info)
            general_info = td_acct_inq_rs.try(:td_acct_gen_info)
            if general_info.gen_ledger_sub_head
              account.gl_code = general_info.gen_ledger_sub_head.gen_ledger_sub_head_code
              account.gl_currency = general_info.gen_ledger_sub_head.cur_code
            end
            account.acct_name = general_info.acct_name
            account.acct_short_name = general_info.acct_short_name
          end

          if account && td_acct_inq_rs.acct_bal_amt
            bal = td_acct_inq_rs.acct_bal_amt
            account.account_balance = bal.to_amount
          end
          if td_acct_inq_rs
            account.opening_date = td_acct_inq_rs.acct_opn_dt
            account.mode_of_operation = td_acct_inq_rs.mode_of_oper
            account.status = td_acct_inq_rs.bank_acct_status_code
            account.customer = td_acct_inq_rs.cust_id.to_customer
            account.freeze_status = td_acct_inq_rs.freeze_status_code

            if td_acct_inq_rs.total_int_amt
              account.total_interest_amount = td_acct_inq_rs.total_int_amt.to_amount
            end

            if td_acct_inq_rs.initial_deposit
              account.initial_deposit = td_acct_inq_rs.initial_deposit.to_amount
            end

            if td_acct_inq_rs.curr_deposit
              account.current_deposit = td_acct_inq_rs.curr_deposit.to_amount
            end

            if td_acct_inq_rs.maturity_amt
              account.maturity_amount = td_acct_inq_rs.maturity_amt.to_amount
            end

            if td_acct_inq_rs.orig_maturity_amt
              account.orig_maturity_amount = td_acct_inq_rs.orig_maturity_amt.to_amount
            end

            if td_acct_inq_rs.deposit_term
              account.deposit_term = td_acct_inq_rs.deposit_term.to_term
            end
            if td_acct_inq_rs.maturity_dt
              account.maturity_date = td_acct_inq_rs.maturity_dt
            end

            if td_acct_inq_rs.net_int_rate
              account.net_interest_rate = td_acct_inq_rs.net_int_rate.value
            end
            if td_acct_inq_rs.renewal_dtls
              account.renewal_details = td_acct_inq_rs.renewal_dtls.to_renewal_details
            end
            if td_acct_inq_rs.rel_party_recs
              td_acct_inq_rs.rel_party_recs.each do |party|
                account.related_parties.push(party.to_related_party)
              end
            end
          end

          return account
        end

      end
    end
  end
end
