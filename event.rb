class Event
	def initialize(data = {})
	  @name = data[:name]
	  @id = data[:id]
	  @purchase_url = data[:url]
	  @image = data[:images].first[:url]
	  @on_sale = data[:sales][:public][:startDateTime]
	  @date = data[:dates][:start][:dateTime]
	  @price_min = data[:priceRanges] ? data[:priceRanges][0][:min] : nil
	  @price_max = data[:priceRanges] ? data[:priceRanges][0][:max] : nil
	  @currency = data[:priceRanges] ? data[:priceRanges][0][:currency] : nil
	  @seatmap = data[:seatmap] ? data[:seatmap][:staticUrl] : nil
	  @limit = data[:ticketLimit] ? data[:ticketLimit][:info] : nil
	  @venue = data[:_embedded][:venues][0][:name]
	end
end
