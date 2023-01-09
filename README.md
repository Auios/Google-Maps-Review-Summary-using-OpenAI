# Google Maps Review Summary using OpenAI
 
# Requirements
This requires two environment variables:
* `GOOGLE_API_KEY`
Your Google API key

* `OPENAI_API_KEY`
Your OpenAI API key

# Usage
```rb
require_relative 'ai'
require_relative 'place'

Place.init(ENV['GOOGLE_API_KEY'])
AI.init(ENV['OPENAI_API_KEY']);

place_id = Place.get_place_id("Starbucks in New York City");
reviews = Place.reviews(place_id);
prompt = AI.generate_prompt_from_reviews(reviews);
summary = AI.ask(prompt);

puts(JSON.pretty_generate(summary));
```

# Sample
## Input
"Starbucks in New York City"

## Output
"These reviews generally recommend that visitors to the Starbucks in New York's Flatiron District visit, due to the charm of the store, the food and drink offerings, and the demonstrations on coffee roasting. Reviewers note that the prices are a bit higher than at other Starbucks locations, but that the value is worth it."
