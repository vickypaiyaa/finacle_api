require 'finacle_api/models/account'

class UnknownAccount < Account
  include ActiveModel::Dirty
  include ActiveModel::Validations

end