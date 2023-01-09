require 'json'
require 'uri'
require 'net/http'
require "ruby/openai"

class AI
	def self.init(api_key)
		@client = OpenAI::Client.new(access_token: api_key)
	end

	def self.generate_prompt_from_reviews(reviews)
		return nil if reviews.nil?
		prompt = []
		prompt.push("Summarize these reviews:")
		prompt.push(JSON.pretty_generate(reviews))

		return prompt.join("\n")
	end

	def self.ask(prompt)
		return nil if prompt.nil?
		response = @client.completions(
			parameters: {
				model: "text-davinci-001",
				prompt: prompt,
				max_tokens: 500
			})
		return response["choices"][0]['text'].strip()
	end
end