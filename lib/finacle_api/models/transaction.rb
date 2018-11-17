require 'finacle_api/common/serializable_object'

module FinacleApi
  class Transaction < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations
    # include ActiveModel::Observing

    attr_accessor :txn_id, :category, :serial_no, :value_date, :pstd_date, 
                  :txn_date, :instrument_id, :amount, :type, :desc, :closing_balance

    def ref_no
      return instrument_id if instrument_id
      return serial_no if serial_no
    end

    def transaction_type
      case type
      when 'C'
        return 'Credit'
      when 'D'
        return 'Debit'
      end
    end

    def credit?
      type == 'C'
    end

    def debit?
      type == 'D'
    end

    def value_date
      DateTime.strptime("#{@value_date}", '%Y-%m-%dT%H:%M:%S') rescue @value_date
    end

    def txn_date
      DateTime.strptime("#{@txn_date}", '%Y-%m-%dT%H:%M:%S') rescue @txn_date
    end

  end
end
