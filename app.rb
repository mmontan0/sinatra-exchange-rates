require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do

  exchange_api=ENV.fetch("EXCHANGE_KEY")
  api_url="https://api.exchangerate.host/list?access_key=#{exchange_api}"
  @raw_response=HTTP.get(api_url)
  @raw_string=@raw_response.to_s
  @parsed_data=JSON.parse(@raw_string)

  @currencies=@parsed_data.fetch("currencies")
  
 erb(:homepage)
end

get("/:first_symbol") do
  @first_symbol=params.fetch("first_symbol")

  exchange_api=ENV.fetch("EXCHANGE_KEY")
  api_url="https://api.exchangerate.host/list?access_key=#{exchange_api}"
  @raw_response=HTTP.get(api_url)
  @raw_string=@raw_response.to_s
  @parsed_data=JSON.parse(@raw_string)

  @currencies=@parsed_data.fetch("currencies")


 erb(:from_currency)
end


get("/:first_symbol/:second_symbol") do
  @first_symbol=params.fetch("first_symbol")
  @second_symbol=params.fetch("second_symbol")

  exchange_api=ENV.fetch("EXCHANGE_KEY")
  api_url="https://api.exchangerate.host/convert?access_key=#{exchange_api}&from=#{@first_symbol}&to=#{@second_symbol}&amount=1"
  @raw_response=HTTP.get(api_url)
  @raw_string=@raw_response.to_s
  @parsed_data=JSON.parse(@raw_string)

  @amount=@parsed_data.fetch("result")
 
 erb(:from_to_currency)
end
