require 'finacle_api/common/serializable_object'
module FinacleApi

  class Branch < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations
    # include ActiveModel::Observing

    attr_accessor :name, :branch_id, :address, :bank_id

    def full_name
      "#{branch_id} - #{name}"
    end
  end
end
