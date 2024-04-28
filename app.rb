require "sinatra"
require "sinatra/reloader"

exchange_api=ENV.fetch("EXCHANGE_KEY")

get("/") do
 erb(:homepage)
end
