require_relative 'ai'
require_relative 'place'

Place.init(ENV['GOOGLE_API_KEY'])
AI.init(ENV['OPENAI_API_KEY']);

place_id = Place.get_place_id("Starbucks in New York City");
reviews = Place.reviews(place_id);
prompt = AI.generate_prompt_from_reviews(reviews);
summary = AI.ask(prompt);

puts(JSON.pretty_generate(summary));
