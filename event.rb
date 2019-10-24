class Event
	def initialize(data = {})
	  @name = data[:name]
	  @id = data[:id]
	  @purchase_url = data[:url]
	  @image = data[:images].first[:url]
	  @on_sale = data[:sales][:public][:startDateTime]
	  @date = data[:dates][:start][:dateTime]
	  @price_min = data[:priceRanges][:min]
	  @price_max = data[:priceRanges][:max]
	  @currency = data[:priceRanges][:currency]
	  @seatmap = data[:seatmap][:staticUrl]
	  @limit = data[:ticketLimit][:info]
	  @venue = data[:embedded][:venues][:name]
	  @event_homepage = data[:embedded][:attractions][:externalLinks][:homepage]
	end
  end