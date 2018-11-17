require 'finacle_api/common/serializable_object'

module FinacleApi

  class Account < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :acct_id, :channel_cust_id, :product_category, :product_code, :currency, :scheme_code, :scheme_type,
                  :opening_date, :status, :mode_of_operation, :closure_date,
                  :gl_code, :gl_currency, :interest_rate_code, :net_interest_rate, :accrual_interest_rate,
                  :acct_name, :acct_short_name, :freeze_status

    attr_accessor :customer, :branch, :account_balance, :related_parties, :interest_calc_frequency, :balances

    def initialize(options={})
      @related_parties = options.delete(:related_parties) || []
      options.each do |key, value|
        send(:"#{key}=", value) if respond_to?(:"#{key}=")
      end
    end

    def closed?
      status == 'Closed'
    end

    def closure_date
      DateTime.strptime("#{@closure_date}", '%Y-%m-%dT%H:%M:%S') rescue @closure_date
    end

    def opening_date
      DateTime.strptime("#{@opening_date}", '%Y-%m-%dT%H:%M:%S') rescue @opening_date
    end

  end # Account

end