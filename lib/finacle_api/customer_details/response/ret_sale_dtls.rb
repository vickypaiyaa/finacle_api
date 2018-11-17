require 'finacle_api/common/serializable_object'
require 'finacle_api/customer_details/response/sale_cust'
require 'finacle_api/customer_details/response/sale_channel_dtls'
require 'finacle_api/customer_details/response/product_dtls_info'

require 'finacle_api/models/account'

module FinacleApi
  module CustomerDetails
    module ResponseEntity

      class RetSaleDtls < SerializableObject
        attr_accessor :product_dtls_info, :sale_channel_dtls, :sale_cust, :prod_cat_id, :acct_branch_code, :acct_id, :channel_cust_id, :channel_name, 
            :is_master_acct, :is_multi_curr_acct, :product_category, :product_code, :is_revolving_od_acct, :top_up_flag

        def initialize(options={})
          options ||= {}
          @sale_cust = SaleCust.new(options.delete(:sale_cust))
          @sale_channel_dtls = SaleChannelDtls.new(options.delete(:sale_channel_dtls))
          @product_dtls_info = ProductDtlsInfo.new(options.delete(:product_dtls_info))
          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_account
          p "inhere acccount"
          a = Account.new( acct_id: acct_id, channel_cust_id: channel_cust_id, product_category: product_category, 
                  product_code: product_code, currency_code: try(:sale_channel_dtls).try(:acct_curr_code), 
                  opening_date: try(:sale_channel_dtls).try(:acct_opening_dt), 
                  status: try(:sale_channel_dtls).try(:acct_status), 
                  mode_of_operation: try(:sale_channel_dtls).try(:mode_of_operation), 
                  acct_branch_code: acct_branch_code)
          p "a.inspect #{a.inspect}"

          a
        end

      end
    end
  end
end