require 'sinatra'
require 'faraday'
require 'dotenv/load'
require 'pry'
require 'fast_jsonapi'
require_relative 'event_serializer'
require_relative 'event'

get "/search" do
    keyword = params[:keyword]
    conn = Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |f|
        f.adapter  Faraday.default_adapter
        f.params[:apikey] = ENV['DISCO_API_KEY']
        f.params[:keyword] = keyword
        f.params[:size] = '100'
    end

    response = conn.get("events.json")
    data = JSON.parse(response.body, symbolize_names: true)

    event_data = data[:_embedded][:events]

    events = event_data.map do |event|
        Event.new(event)
    end

    EventSerializer.new(events).to_json
end

get "/colorado" do
    conn = Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |f|
        f.adapter  Faraday.default_adapter
        f.params[:apikey] = ENV['DISCO_API_KEY']
        f.params[:stateCode] = 'co'
        f.params[:size] = '100'
    end

    response = conn.get("events.json")
    data = JSON.parse(response.body, symbolize_names: true)

    event_data = data[:_embedded][:events]

    events = event_data.map do |event|
        Event.new(event)
    end

    EventSerializer.new(events).to_json
end

get "/all" do
    conn = Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |f|
        f.adapter  Faraday.default_adapter
        f.params[:apikey] = ENV['DISCO_API_KEY']
        f.params[:size] = '100'
    end

    response = conn.get("events.json")
    data = JSON.parse(response.body, symbolize_names: true)

    event_data = data[:_embedded][:events]

    events = event_data.map do |event|
        Event.new(event)
    end

    EventSerializer.new(events).to_json
end

run Sinatra::Application.run!
