require 'sinatra'
require 'faraday'
require 'dotenv/load'
require 'pry'
require 'fast_jsonapi'
require_relative 'event_serializer'
require_relative 'event'
require_relative 'ticketmaster_api_service'

get "/search" do
  service = TicketmasterApiService.create_events("events.json", {keyword: params[:keyword]})
  EventSerializer.new(service).to_json
end

get "/colorado" do
  service = TicketmasterApiService.create_events("events.json", {stateCode: 'CO'})
  EventSerializer.new(service).to_json
end


get "/all" do
  service = TicketmasterApiService.create_events("events.json")
  EventSerializer.new(service).to_json
end


run Sinatra::Application.run!
