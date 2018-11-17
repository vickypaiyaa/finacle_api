require 'finacle_api/models/account'

module FinacleApi
  class LoanAccount < Account
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :source_dealer, :disbursement_dealer
    attr_accessor :loan_amount, :disbursement_amount, :amount_already_disbursed, :amount_available_for_disbursement
    attr_accessor :period_days, :period_months, :repayment_method, :operative_account

    attr_accessor :repayment_records #of type Installment
    attr_accessor :multi_source_instruction_records #of type MultiSrcInstruction

  end
end