
require 'json'
require 'net/http'
require 'uri'

# Files
input_file = "function_chunks.json"

# Ollama API settings
OLLAMA_URL = "http://localhost:11434/api/chat"
MODEL_NAME = "llama3"

# Function to query Ollama
def query_ollama(function_text, query, ollama_url, model_name)
  uri = URI(ollama_url)
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request.body = {
    model: model_name,
    messages: [
      { role: "user", content: "Does this function convert a UINavigationBar to green? #{function_text}" }
    ],
    stream: false
  }.to_json

  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end

  if response.code.to_i == 200
    result = JSON.parse(response.body)
    return result.dig("message", "content") || ""
  else
    puts "Error querying Ollama: #{response.code} - #{response.body}"
    return nil
  end
end

# Load function data
functions = JSON.parse(File.read(input_file))

# Query for matching function
query = "Does this function convert a UINavigationBar to green?"
matches = []

functions.each do |func|
  sourcetext = func["sourcetext"]
  if sourcetext
    puts "Analyzing function: #{func['name']}"
    result = query_ollama(sourcetext, query, OLLAMA_URL, MODEL_NAME)
    if result && result.downcase.include?("yes") # Look for a positive match
      matches << { name: func["name"], details: func, result: result }
    end
  else
    puts "Skipping function: #{func['name']} (No sourcetext available)"
  end
end

# Print matches
if matches.any?
  puts "Matching Functions Found:"
  matches.each do |match|
    puts "Function Name: #{match[:name]}"
    puts "Details: #{match[:details]}"
    puts "Explanation: #{match[:result]}"
    puts "---"
  end
else
  puts "No matching functions found."
end
