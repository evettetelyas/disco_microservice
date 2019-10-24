require 'sinatra'
require 'faraday'
require 'figaro/sinatra'

get '/' do
	conn = Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |f|
		f.adapter  Faraday.default_adapter
		f.params[:apikey] = ENV['DISCO_API_KEY']
	end

	response = conn.get("events.json")
	response.body
end

run Sinatra::Application.run!