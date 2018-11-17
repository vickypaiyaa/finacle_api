require 'finacle_api/common/serializable_object' 
module FinacleApi
  module CustChqBook
    module ResponseEntity
      class ExecuteFinacleScriptCustomData < SerializableObject
        attr_accessor :status, :message, :success_or_failure, :chq_alwd_flg, 
                      :error_code, :error_msg, :frez_code, :acct_cls_flg, :acct_status

        def response_message
          response_message = @message if @message.present?
          response_message ||= @acct_status if @acct_status.present?
          response_message ||= @acct_cls_flg if @acct_cls_flg.present?
          response_message ||= @frez_code if @frez_code.present?
          response_message ||= @error_msg if @error_msg.present?
          response_message ||= @chq_alwd_flg if @chq_alwd_flg.present?
          response_message
        end

        def success?
          status == 'SUCCESS' || success_or_failure == 'Y'
        end

      end
    end
  end
end
