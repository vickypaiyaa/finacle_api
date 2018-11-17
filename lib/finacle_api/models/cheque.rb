require 'finacle_api/common/serializable_object'
module FinacleApi

  class Cheque < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations
    # include ActiveModel::Observing

    attr_accessor :account, :branch, :serial_no, :amount, :currency, :desc, :txn_date, :pstd_date

  end

end
