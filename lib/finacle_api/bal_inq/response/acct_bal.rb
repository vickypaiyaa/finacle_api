require 'finacle_api/common/serializable_object'
require 'finacle_api/bal_inq/response/bal_amt'
require 'finacle_api/models/account_balance'

module FinacleApi
  module BalInq
    module ResponseEntity
      class AcctBal < SerializableObject
        attr_accessor :bal_type, :bal_amt
        def initialize(options={})
          options ||= {}
          @bal_amt = BalAmt.new(options.delete(:bal_amt))
          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_account_balance
          ab = AccountBalance.new(balance_type: bal_type)
          ab.balance_amount = bal_amt.to_amount if bal_amt
          ab
        end

      end
    end
  end
end