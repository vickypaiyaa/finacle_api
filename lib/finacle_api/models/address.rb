require 'finacle_api/common/serializable_object'
module FinacleApi

  class Address < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations
    # include ActiveModel::Observing

    attr_accessor :addr_line1, :addr_line2, :addr_line3, :city, :state, :postal_code, :country

    def in_full
      [addr_line1, addr_line2, addr_line3, city, state, postal_code, country].
      select{|a| a != "null"}.
      compact.join(", ")
    end

  end
end
