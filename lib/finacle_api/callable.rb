require 'finacle_api/bal_inq/api'
require 'finacle_api/block_modify/api'
require 'finacle_api/xfer_trn_add/api'
require 'finacle_api/stop_chk_add/api'
require 'finacle_api/de_duplication_inq/api'
require 'finacle_api/get_cheques_for_chequebook/api'
require 'finacle_api/customer_details/api'
require 'finacle_api/od_acct_inq/api'
require 'finacle_api/td_acct_inq/api'
require 'finacle_api/loan_acct_inq/api'
require 'finacle_api/last_n_transactions/api'
require 'finacle_api/cust_chq_book/api'

# add your api call functions here

module FinacleApi
  module Callable
    include FinacleApi::BalInq::API
    include FinacleApi::BlockModify::API
    include FinacleApi::XferTrnAdd::API
    include FinacleApi::StopChkAdd::API
    include FinacleApi::DeDuplicationInq::API
    include FinacleApi::GetChequesForChequebook::API
    include FinacleApi::CustomerDetails::API
    include FinacleApi::ODAcctInq::API
    include FinacleApi::TDAcctInq::API
    include FinacleApi::LoanAcctInq::API
    include FinacleApi::LastNTransactions::API
    include FinacleApi::CustChqBook::API
  end
end
