require 'json'
require 'uri'
require 'net/http'

class Place
	def self.init(api_key)
		@api_key = api_key
	end

	def self.get_place_id(search)
		uri = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json")
		query = {
			input: search,
			inputtype: "textquery",
			key: @api_key,
		}
		uri.query = URI.encode_www_form(query)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri)
		response = http.request(request)
		response_data = JSON.parse(response.body)

		return nil if (response_data["candidates"].length == 0)
		return response_data["candidates"][0]["place_id"]
	end

	def self.reviews(place_id)
		return nil if place_id.nil?
		uri = URI("https://maps.googleapis.com/maps/api/place/details/json")
		query = {
			place_id: place_id,
			key: @api_key,
			language: 'en',
		}
		uri.query = URI.encode_www_form(query)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri)
		response = http.request(request)
		response_data = JSON.parse(response.body)

		result = response_data['result']
		reviews = []
		result["reviews"].each do |review|
			reviews.push(review['text'])
		end
		return reviews
	end
end
