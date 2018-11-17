require 'sinatra'

# mock server for api integration layer
# this has HTTP BasicAuth enabled
# runs on port 8080
# username: apiservices 
# password: apiservices
# sample usage: curl -vu apiservices:apiservices "http://localhost:8080/api/services/customers?custId=8124141244123123&custType=Retail"

set :port, 8080

use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == 'apiservices' and password == 'jan@2014'
end

get '/api/services/customers' do
  custId=params[:custId] 
  custType=params[:custType]
  if custId.nil? || custId.empty? || custType.nil? || custType.empty?
    erb :customer_details_error_response
  else
    content_type 'text/xml'
    erb :customer_details_response
    # erb :customer_details_error_response
    # erb :customer_details_partial_error_response
  end
end

