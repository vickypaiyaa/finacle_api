require 'finacle_api/common/serializable_object'

module FinacleApi
  class CustomerSearchResult < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :customers, :has_more, :page
    PER_PAGE = 10

    def initialize(options={})
      @customers ||= []
    end

    def current_count
      customers.count
    end

    def error?
      self.errors.present?
    end

  end #class
end