require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

exchange_rate_key = EXCHANGE_RATE_KEY

get("/") do
  erb(:homepage)
end

get("/:currency_to_convert") do
  erb(:to_convert)
end

get("/:currency_to_convert/:conversion_currency") do
  erb(:conversion)
end
