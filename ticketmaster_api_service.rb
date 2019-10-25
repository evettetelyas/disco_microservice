class TicketmasterApiService
  def self.create_events(url, param_hash = {})
    new.get_response(url, param_hash)
  end

  def connection(param_hash)
    Faraday.new(
      url: "https://app.ticketmaster.com/discovery/v2/",
      params: { apikey: ENV['DISCO_API_KEY'],
        size: 100
      }.merge(param_hash)
    )
  end

  def get_response(url, param_hash)
    response = connection(param_hash).get(url)
    raw = JSON.parse(response.body, symbolize_names: true)
    event_objects(raw[:_embedded][:events])
  end

  def event_objects(json_data)
    json_data.map do |event|
        Event.new(event)
    end
  end
end
