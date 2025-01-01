require 'json'
require 'net/http'
require 'uri'

# File paths
input_file = "function_chunks.json"
output_file = "function_chunks_with_embeddings.json"

# Ollama API settings
OLLAMA_URL = "http://localhost:11434/api/embeddings"
MODEL_NAME = "llama3" # Adjust the model name if needed

# Function to generate embeddings
def generate_embedding(text, ollama_url, model_name)
  uri = URI(ollama_url)
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request.body = { model: model_name, input: text }.to_json

  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end

  if response.code.to_i == 200
    JSON.parse(response.body)["embedding"]
  else
    puts "Error generating embedding: #{response.code} - #{response.body}"
    nil
  end
end

# Load functions from JSON
functions = JSON.parse(File.read(input_file))

# Add embeddings to each function
functions.each_with_index do |func, index|
  sourcetext = func["sourcetext"]
  if sourcetext
    puts "Generating embedding for function #{index + 1}/#{functions.size}: #{func['name']}"
    embedding = generate_embedding(sourcetext, OLLAMA_URL, MODEL_NAME)
    func["embedding"] = embedding if embedding
  else
    puts "Skipping function #{index + 1}: No sourcetext available."
  end
end

# Save updated functions with embeddings
File.open(output_file, "w") do |f|
  f.write(JSON.pretty_generate(functions))
end

puts "Embeddings generated and saved to #{output_file}"
