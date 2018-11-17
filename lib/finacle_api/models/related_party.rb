require 'finacle_api/common/serializable_object'

module FinacleApi

  class RelatedParty < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :type, :desc, :code, :code_desc, :del_flag

    #associations
    attr_accessor :customer, :address, :contact_infos

  end # RelatedParty

end