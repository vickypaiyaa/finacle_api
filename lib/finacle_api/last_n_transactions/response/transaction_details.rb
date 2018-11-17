require 'finacle_api/common/serializable_object' 
require 'finacle_api/last_n_transactions/response/transaction_summary' 
require 'finacle_api/last_n_transactions/response/txn_balance' 

require 'finacle_api/models/transaction'

module FinacleApi
  module LastNTransactions
    module ResponseEntity
      class TransactionDetails < SerializableObject
        attr_accessor :pstd_date, :transaction_summary, :txn_balance, :txn_cat, :txn_id, :txn_srl_no, :value_date

        def initialize(options={})
          options ||= {}
          @transaction_summary = TransactionSummary.new(options.delete(:transaction_summary))
          @txn_balance = TxnBalance.new(options.delete(:txn_balance))
          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_transaction
          #summary - :instrument_id, :txn_amt, :txn_date, :txn_desc, :txn_type
          Transaction.new.tap do |t|
            t.txn_id = txn_id.strip if txn_id
            t.category = txn_cat.strip if txn_cat
            t.serial_no = txn_srl_no.strip if txn_srl_no
            t.value_date = value_date if value_date
            t.pstd_date = pstd_date if pstd_date
            if txn_balance
              t.closing_balance = txn_balance.to_amount
            end
            if transaction_summary
              t.instrument_id = transaction_summary.instrument_id.strip  if transaction_summary.instrument_id
              t.amount = transaction_summary.txn_amt.to_amount if transaction_summary.txn_amt
              t.type = transaction_summary.txn_type.strip if transaction_summary.txn_type
              t.desc = transaction_summary.txn_desc.strip if transaction_summary.txn_desc
              t.txn_date = transaction_summary.txn_date.strip if transaction_summary.txn_date
            end
          end
        end

      end
    end
  end
end
