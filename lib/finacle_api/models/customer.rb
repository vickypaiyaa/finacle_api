require 'finacle_api/common/serializable_object'

module FinacleApi

  class Customer < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :crn, :first_name, :last_name, :middle_name, :name, :title_prefix, :gender_code, :start_date, 
                  :segment, :sub_segment, :pan, :cust_type, :birth_dt, :status,
                  :cust_type_code, :nationality

    #associations
    attr_accessor :accounts, :addresses, :contact_info, :home_branch

    def empty?
      crn.nil? || crn.strip.empty?
    end

    def start_date
      DateTime.strptime("#{@start_date}", '%Y-%m-%dT%H:%M:%S') rescue @start_date
    end

    def birth_date
      DateTime.strptime("#{@birth_dt}", '%Y-%m-%dT%H:%M:%S') rescue @birth_dt
      # birth_dt
    end


    def initialize(options={})
      options ||={}
      @accounts ||= []
      @addresses ||= []
      @contact_info ||= []
      options.each do |key, value|
        send(:"#{key}=", value) if respond_to?(:"#{key}=")
      end
    end

    def full_name
      return name if name
      [first_name, middle_name, last_name].join(" ") if first_name || middle_name || last_name
    end

    def primary_address
      addresses.try(:first) || nil
    end

    def customer_type
      @cust_type == 'T001' ? 'Retail' : 'Corporate'
    end

  end #customer

end #module