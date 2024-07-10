require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  @raw_response = HTTP.get(exchange_rate_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)

  @currencies = parsed_response.fetch("currencies").keys

  erb(:homepage)
end

get("/:currency_to_convert") do
  erb(:to_convert)
end

get("/:currency_to_convert/:conversion_currency") do
  erb(:conversion)
end
