require 'finacle_api/models/account'

module FinacleApi
  class TDAccount < Account
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :total_interest_amount, :initial_deposit, :current_deposit, :orig_maturity_amount, :maturity_amount, :maturity_date
    attr_accessor :deposit_term, :renewal_details

    
  end
end