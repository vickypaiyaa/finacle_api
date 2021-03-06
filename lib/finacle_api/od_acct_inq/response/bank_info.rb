require 'finacle_api/common/serializable_object' 
require 'finacle_api/od_acct_inq/response/post_addr' 

require 'finacle_api/models/branch'

module FinacleApi
  module ODAcctInq
    module ResponseEntity
      class BankInfo < SerializableObject
        attr_accessor :bank_id, :name, :branch_id, :branch_name, :post_addr

        def initialize(options={})
          options ||= {}
          @post_addr = PostAddr.new(options.delete(:post_addr))

          options.each do |key, value|
            send(:"#{key}=", value) if respond_to?(:"#{key}=")
          end
        end

        def to_branch
          Branch.new(bank_id: bank_id, branch_id: branch_id, name: branch_name).tap do |b|
            if post_addr
              b.address = post_addr.to_address
            end
          end
        end


      end
    end
  end
end
