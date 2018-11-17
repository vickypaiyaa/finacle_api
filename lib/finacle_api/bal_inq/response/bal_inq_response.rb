require 'finacle_api/common/serializable_object'
require 'finacle_api/bal_inq/response/bal_inq_rs'

module FinacleApi
  module BalInq
    module ResponseEntity
      class BalInqResponse < SerializableObject
        attr_accessor :bal_inq_rs
        def initialize(options={})
          options ||= {}
          @bal_inq_rs = BalInqRs.new(options.delete(:bal_inq_rs))
        end

        def to_balances
          if bal_inq_rs.acct_id
            account = bal_inq_rs.acct_id.to_account
          end
          if account && bal_inq_rs.acct_bals
            account.balances = []
            bal_inq_rs.acct_bals.each do |b|
              account.balances.push(b.to_account_balance)
            end
          end
          account
        end

      end
    end
  end
end