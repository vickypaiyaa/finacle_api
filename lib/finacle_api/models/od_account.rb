require 'finacle_api/models/account'

module FinacleApi
  class ODAccount < Account
    include ActiveModel::Dirty
    include ActiveModel::Validations
  end
end