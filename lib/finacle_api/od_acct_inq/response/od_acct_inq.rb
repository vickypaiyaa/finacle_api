require 'finacle_api/common/serializable_object' 
require 'finacle_api/od_acct_inq/response/acct_type' 
require 'finacle_api/od_acct_inq/response/bank_info' 

require 'finacle_api/models/od_account'

module FinacleApi
  module ODAcctInq
    module ResponseEntity
      class ODAcctInq < SerializableObject
        attr_accessor :acct_id, :acct_type, :acct_curr, :bank_info

        def initialize(options={})
          options ||= {}
          @acct_type = AcctType.new(options.delete(:acct_type))
          @bank_info = BankInfo.new(options.delete(:bank_info))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_account
          ODAccount.new(acct_id: acct_id, currency: acct_curr ).tap do |a|
            if acct_type
              a.scheme_code = acct_type.schm_code
              a.scheme_type = acct_type.schm_type
            end
            if bank_info
              a.branch = bank_info.to_branch
            end
          end #Account.new
        end

      end
    end
  end
end
