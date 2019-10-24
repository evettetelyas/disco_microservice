require 'sinatra'
require 'faraday'
require 'figaro/sinatra'
require 'pry'
require 'fast_jsonapi'
require_relative 'event_serializer'

get "/all_us_events" do
	conn = Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |f|
		f.adapter  Faraday.default_adapter
		f.params[:apikey] = ENV['DISCO_API_KEY']
		f.params[:countryCode] = 'US'
	end

	response = conn.get("events.json")
	data = JSON.parse(response.body, symbolize_names: true)

	events = EventSerializer.new(data[:_embedded][:events])
	binding.pry
end

get "/search" do
	keyword = params[:keyword]
	conn = Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |f|
		f.adapter  Faraday.default_adapter
		f.params[:apikey] = ENV['DISCO_API_KEY']
		f.params[:keyword] = keyword
	end

	response = conn.get("events.json")
	response.body
end



run Sinatra::Application.run!