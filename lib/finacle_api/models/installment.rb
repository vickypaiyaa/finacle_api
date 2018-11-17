require 'finacle_api/common/serializable_object'
module FinacleApi

  class Installment < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :installment_id, :start_dt, :number_of_installments
    attr_accessor :installment_frequency, :interest_frequency


    def start_date
      DateTime.strptime("#{@start_dt}", '%Y-%m-%dT%H:%M:%S') rescue @start_dt
    end

  end
end