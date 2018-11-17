require 'finacle_api/common/serializable_object'
module FinacleApi

  class RenewalDetails < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :renewal_term, :scheme_code, :scheme_type, :auto_renewal_flag, :auto_close_on_maturity
                  :renewal_option
    attr_accessor :gl_code, :gl_currency
    attr_accessor :renewal_amount, :renewal_additional_amount, :source_account
  end

end