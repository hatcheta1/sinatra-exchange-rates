require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
puts exchange_rate_key

get("/") do
  exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"

  resp = HTTP.get(exchange_rate_url)
  raw_response = resp.to_s
  parsed_response = JSON.parse(raw_response)

  @currencies = parsed_response.fetch("currencies")
  erb(:homepage)
end

get("/:currency_to_convert") do
  erb(:to_convert)
end

get("/:currency_to_convert/:conversion_currency") do
  erb(:conversion)
end
