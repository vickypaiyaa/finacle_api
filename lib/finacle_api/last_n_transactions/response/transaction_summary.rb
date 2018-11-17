require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/response/txn_amt' 
module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class TransactionSummary < SerializableObject
        attr_accessor :instrument_id, :txn_amt, :txn_date, :txn_desc, :txn_type

        def initialize(options={})
          options ||= {}
          @txn_amt = TxnAmt.new(options.delete(:txn_amt))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end
      end
    end
  end
end
