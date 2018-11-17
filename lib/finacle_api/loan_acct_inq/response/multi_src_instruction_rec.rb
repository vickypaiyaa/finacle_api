require 'finacle_api/common/serializable_object' 
require 'finacle_api/loan_acct_inq/response/recovery_acct_id' 
require 'finacle_api/loan_acct_inq/response/value_in_amt' 
require 'finacle_api/loan_acct_inq/response/value_in_percent' 
require 'finacle_api/loan_acct_inq/response/acct_id' 

require 'finacle_api/models/multi_src_instruction'

module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class MultiSrcInstructionRec < SerializableObject
        attr_accessor :recovery_acct_id, :install_type, :re_pmt_method, :amt_percent_ind, :value_in_amt, :value_in_percent, :acct_id

        def initialize(options={})
          options ||= {}
          @recovery_acct_id = RecoveryAcctId.new(options.delete(:recovery_acct_id))
          @value_in_amt = ValueInAmt.new(options.delete(:value_in_amt))
          @value_in_percent = ValueInPercent.new(options.delete(:value_in_percent))
          @acct_id = AcctId.new(options.delete(:acct_id))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_multi_src_instruction
          MultiSrcInstruction.new(installment_type: install_type, repayment_method: re_pmt_method, 
                    amount_percent_indicator: amt_percent_ind).tap do |r|
            r.recovery_account_id = recovery_acct_id.acct_id if recovery_acct_id.acct_id
            r.recovery_account_currency = recovery_acct_id.acct_curr if recovery_acct_id.acct_curr
            r.value_percent = value_in_percent.value if value_in_percent && value_in_percent.value
            r.value_percent = value_in_percent.value if value_in_percent && value_in_percent.value
            r.value_amount = value_in_amt.to_amount if value_in_amt

            r.account_id = acct_id.acct_id if acct_id.acct_id
            r.account_curr = acct_id.acct_id if acct_id.acct_curr
          end

        end
      end
    end
  end
end
