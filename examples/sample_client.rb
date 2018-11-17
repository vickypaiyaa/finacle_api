require 'finacle_api'

c = FinacleApi::Client.new(:user_id => '01212', :password => 'passpass', :endpoint => 'https://localhost:8443')
sc = FinacleApi::ServicesClient.new(:user_id => 'apiservices', :password => 'jan@2014', :endpoint => 'http://localhost:8080')

# r1 = c.balance_inquiry('1007710010000223')
# p "BalInq: RESPONSE OBJECT ~> [#{r1.inspect}]"


# r2 = c.mark_lien('ARJSB2', 10, '0001', {:block_id => 'TEST', :reason_code => '001'})
# p "BlockModify: RESPONSE OBJECT ~> [#{r2.inspect}]"
# p "BlockModify: Stan is #{r2.block_modify_output_vo.stan}"


# r3 = c.cash_drop('1008810030000203','1008810030000286', 10,
#    {:value_dt => "2012-12-12T00:00:00.000",
#     :pmt_inst => {
#       :pmt_inst_dt => "2013-12-11T00:00:00.000",
#       :pmt_inst_alpha => '#$',

# r3 = c.cash_drop('1008810030000203','1008810030000286', 10,
#    {:value_dt => "2012-12-12T00:00:00.000",
#     :pmt_inst => {
#       :pmt_inst_dt => "2013-12-11T00:00:00.000",
#       :pmt_inst_alpha => '#$',

#       :pmt_inst_num => '123456'
#     }
#   }
# )


# p "XferTrnAdd CASHDROP: RESPONSE OBJECT ~> [#{r3.inspect}]"
# p "XferTrnAdd CASHDROP: Transaction Date is #{r3.xfer_trn_add_rs.trn_identifier.trn_dt}"

# r4 = c.cash_pickup('1008810030000203','1008810030000286', 10,
#   {:currency_code => 'INR',
#     :value_dt => "2013-04-11T00:00:00.000",
#     :pmt_inst => {
#       :pmt_inst_dt => "2013-04-11T00:00:00.000",
#       :pmt_inst_alpha => '#$',


# p "XferTrnAdd CASHDROP: RESPONSE OBJECT ~> [#{r3.inspect}]"
# p "XferTrnAdd CASHDROP: Transaction Date is #{r3.xfer_trn_add_rs.trn_identifier.trn_dt}"

# r4 = c.cash_pickup('1008810030000203','1008810030000286', 10,
#   {:currency_code => 'INR',
#     :value_dt => "2013-04-11T00:00:00.000",
#     :pmt_inst => {
#       :pmt_inst_dt => "2013-04-11T00:00:00.000",
#       :pmt_inst_alpha => '#$',

#       :pmt_inst_num => '123456'
#     }
#   }
# )
# p "XferTrnAdd CASH PICKUP: RESPONSE OBJECT ~> [#{r4.inspect}]"
# p "XferTrnAdd CASH PICKUP: Transaction Date is #{r4.xfer_trn_add_rs.trn_identifier.trn_dt}"

#r4 = c.stop_payment('1008810030000203','030', 'smsm', '3', '2013-04-11T00:00:00.000')


# r5 = c.customer_search(:first_name => 'Shaikh')
# p "DeDuplicationInq RESPONSE OBJECT ~> |#{r5.customers.inspect}|"

# r6 = sc.customer_details('8123994377847718')
# p "Customer Details Result |~|#{r6.inspect}|~|"

# r7 = c.od_account_details('8123994377847718')
# p "OD Account Details - ||#{r7.inspect}||"

# r8 = c.td_account_details('8123994377847718')
# p "TD Account Details - [#{r8.inspect}]"

# r9 = c.loan_account_details('8123994377847718')
# p "Loan Account Details - [#{r9.inspect}]"

# r10 = c.get_cheque_details('1001010030004242', '22793', '0001', '22796') #account_number, begin_cheque_number, account_branch_id, end_cheque_number
# p "Cheque Details - [#{r10.inspect}]"

r11 = c.transactions('1001010030004242', '0001', 15) #account_number, branch_id, number_of_transactions
p "Last 15 transactions - [#{r11.inspect}]"

# r12 = c.cheque_book_request('1001010030004242', 'A') #account_number, cheque_type
# p "Cheque Book Request - RESPONSE - [message=#{r12.execute_finacle_script_custom_data.response_message}; success?=#{r12.execute_finacle_script_custom_data.success?}]"



