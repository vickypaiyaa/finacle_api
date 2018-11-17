require 'nokogiri'
require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'

#CERT_PATH = '/mnt/code/xbit/finacle_api/certs/'
CERT_PATH = 'certs/'

# Finacle API mock server
#
# This will run in port 8443 as an https server
# Will respond with sample requests and responses in examples/views folder
# curl command: curl https://localhost:8443/FISERVLET/fihttp -k -d @examples/views/de_duplication_inq_request.xml
# require nokogiri to be installed
# to be run as 'ruby examples/fin_api_server.rb'

class SSLServer < Sinatra::Base

  post '/FISERVLET/fihttp' do
    #p "request is [ #{request.inspect} ]"
    raw = request.env["rack.input"].read
    #p "XML DATA ~ [#{raw.inspect}]"
    req_xml = raw    
    xdoc = Nokogiri::XML(req_xml)
    sr_tag = xdoc.xpath('//fixml:ServiceRequestId', 'fixml' => 'http://www.finacle.com/fixml').first
    sr_val = sr_tag.children.first if sr_tag && sr_tag.children
    sr_id = sr_val.content.gsub(/\"/, '') if sr_val.content
    #p "SR ID ~ |#{sr_id.content.inspect}"
    if sr_id=='RetCustInq'
      erb :ret_cust_inq_response
    elsif sr_id=='RetCustAcctInq'
      erb :ret_cust_acct_inq_response
    elsif sr_id=='DeDuplicationInq'
      erb :de_duplication_inq_response
    elsif sr_id=='StopChkAdd'
      erb :stop_chk_add_response
    elsif sr_id=='XferTrnAdd'  
      erb :xfer_trn_add_response
    elsif sr_id=='BalInq'
      erb :bal_inq_response
    elsif sr_id=='getChequesForChequebook'
      erb :getChequesForChequebookResponse
    elsif sr_id=='ODAcctInq'
      erb :od_acct_inq_response
    elsif sr_id=='TDAcctInq'
      erb :td_acct_inq_response
    elsif sr_id=='LoanAcctInq'
      erb :loan_acct_inq_response
    elsif sr_id=='getLastNTransactionsWithPagination'
      erb :last_n_transactions_response
    elsif sr_id=='executeFinacleScript'
      request_id_tag = xdoc.xpath('//fixml:requestId', 'fixml' => 'http://www.finacle.com/fixml').first
      req_id_node = request_id_tag.children.first if request_id_tag && request_id_tag.children
      req_id_val = req_id_node.content.gsub(/\"/, '') if req_id_node.content
      if req_id_val=='custChqBookRequest'
        erb :cust_chq_book_response
      else
        erb :system_error_response
      end

    else
      erb :system_error_response
    end
  end


  # def self.run!
  #   rack_handler_config = {}

  #   ssl_options = {
  #     :private_key_file => '/mnt/code/xbit/certs/server.key',
  #     :cert_chain_file => '/mnt/code/xbit/certs/server.crt',
  #     :verify_peer => false,
  #   }

  #   Rack::Handler::Thin.run(self, rack_handler_config) do |server|
  #     server.ssl = true
  #     server.ssl_options = ssl_options
  #   end
  # end


end

#Rack::Handler::WEBrick.run SSLServer, webrick_options

webrick_options = {
        :Port               => 8443,
        :Logger             => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG),
        :DocumentRoot       => "",
        :SSLEnable          => true,
        :SSLVerifyClient    => OpenSSL::SSL::VERIFY_NONE,
        :SSLCertificate     => OpenSSL::X509::Certificate.new(  File.open(File.join(CERT_PATH, "server.crt")).read),
        :SSLPrivateKey      => OpenSSL::PKey::RSA.new(          File.open(File.join(CERT_PATH, "server.key")).read),
        :SSLCertName        => [ [ "CN",WEBrick::Utils::getservername ] ],
        :app                => SSLServer
}

Rack::Server::start webrick_options
