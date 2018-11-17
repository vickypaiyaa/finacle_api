require 'finacle_api/common/serializable_object' 
require 'finacle_api/loan_acct_inq/response/loan_acct_inq_rs' 
require 'finacle_api/loan_acct_inq/response/loan_acct_inq_custom_data' 
module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class LoanAcctInqResponse < SerializableObject
        attr_accessor :loan_acct_inq_rs, :loan_acct_inq_custom_data

        def initialize(options={})
          @loan_acct_inq_rs = LoanAcctInqRs.new(options.delete(:loan_acct_inq_rs))
          @loan_acct_inq_custom_data = LoanAcctInq_CustomData.new(options.delete(:loan_acct_inq_custom_data))
        end

        def to_loan_account
          account = nil
          if loan_acct_inq_rs && loan_acct_inq_rs.loan_acct_id
            account = loan_acct_inq_rs.loan_acct_id.to_account
          end

          if account && loan_acct_inq_rs.try(:loan_acct_gen_info)
            general_info = loan_acct_inq_rs.try(:loan_acct_gen_info)
            if general_info.gen_ledger_sub_head
              account.gl_code = general_info.gen_ledger_sub_head.gen_ledger_sub_head_code
              account.gl_currency = general_info.gen_ledger_sub_head.cur_code
            end
            account.acct_name = general_info.acct_name
            account.acct_short_name = general_info.acct_short_name
          end

          if account && loan_acct_inq_rs.amt_already_disb
            account.amount_already_disbursed = loan_acct_inq_rs.amt_already_disb.to_amount
          end

          if account && loan_acct_inq_rs.amt_avail_for_disb
            account.amount_already_disbursed = loan_acct_inq_rs.amt_avail_for_disb.to_amount
          end

          if account && loan_acct_inq_rs.disb_amt
            account.disbursement_amount = loan_acct_inq_rs.disb_amt.to_amount
          end

          if account && loan_acct_inq_rs.src_dealer_code
            account.source_dealer = loan_acct_inq_rs.src_dealer_code.to_dealer
          end

          if account && loan_acct_inq_rs.disb_dealer_code
            account.disbursement_dealer = loan_acct_inq_rs.disb_dealer_code.to_dealer
          end

          if loan_acct_inq_rs
            account.opening_date = loan_acct_inq_rs.acct_open_dt
            account.mode_of_operation = loan_acct_inq_rs.mode_of_oper
            account.customer = loan_acct_inq_rs.cust_id.to_customer

            if loan_acct_inq_rs.net_int_rate
              account.net_interest_rate = loan_acct_inq_rs.net_int_rate.value
            end
            if loan_acct_inq_rs.loan_gen_details
              loan_data = loan_acct_inq_rs.loan_gen_details
              account.period_days = loan_data.loan_period_days
              account.period_months = loan_data.loan_period_months
              account.repayment_method = loan_data.re_pmt_method
              account.operative_account = loan_data.oper_acct_id.to_account
              if account && loan_data.loan_amt
                account.loan_amount = loan_data.loan_amt.to_amount
              end
              account.repayment_records ||= []
              loan_data.pmt_plan.repmt_recs.each do |pr|
                account.repayment_records.push(pr.to_installment)
              end
            end
            account.multi_source_instruction_records ||= []
            loan_acct_inq_rs.multi_src_instruction_recs.each do |msi|
              account.multi_source_instruction_records.push(msi.to_multi_src_instruction)
            end
            if loan_acct_inq_rs.rel_party_recs
              loan_acct_inq_rs.rel_party_recs.each do |party|
                account.related_parties.push(party.to_related_party)
              end
            end
          end #if loan_acct_inq_rs
          return account
        end

      end
    end
  end
end
