require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")

get("/") do
  exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"

  @raw_response = HTTP.get(exchange_rate_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)

  @currencies = @parsed_data.fetch("currencies")

  erb(:homepage)
end

get("/:currency_to_convert") do
  @original_currency = params.fetch("currency_to_convert")

  exchange_rate_url = exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"

  @raw_response = HTTP.get(exchange_rate_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)

  @currencies = @parsed_data.fetch("currencies")

  erb(:to_convert)
end

get("/:currency_to_convert/:conversion_currency") do
  @original_currency = params.fetch("currency_to_convert")
  @destination_currency = params.fetch("conversion_currency")

  exchange_rate_url = "https://api.exchangerate.host/convert?access_key=#{exchange_rate_key}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  @raw_response = HTTP.get(exchange_rate_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)

  @result = @parsed_data.fetch("result")

  erb(:conversion)
end
