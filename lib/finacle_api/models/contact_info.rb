require 'finacle_api/common/serializable_object'

module FinacleApi 
  class ContactInfo < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations
    # include ActiveModel::Observing

    attr_accessor :sub_category, :value, :category, :preferred

    #category = PHONE or EMAIL
    #sub_category = Home / Work / Cell
    def type
      "#{sub_category} #{category}".upcase
    end

  end

end
