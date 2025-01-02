require 'net/http'
require 'json'

# Configuration
LLAMA3_API_URL = "http://localhost:11434/api/chat" # Replace with your Ollama endpoint
INPUT_FILE = "test.swift"
OUTPUT_FILE = "annotated.swift"

# Regex to extract Swift functions
FUNCTION_REGEX = /func\s+\w+\s*\([^)]*\)\s*\{/

def fetch_documentation(function_code)
    puts("make request")
  uri = URI(LLAMA3_API_URL)
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  
  request.body = {
    model: "llama3",
    messages: [
      { role: "user", content: "Add a Swift documentation comment above this function:\n\n#{function_code}" }
    ],
    stream: false
  }.to_json

  response = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(request) }
puts("here")
  if response.is_a?(Net::HTTPSuccess)
    puts(response.body)
    JSON.parse(response.body)["message"]['content']&.strip
  else
    puts "Error: #{response.code} - #{response.body}"
    nil
  end
end

def annotate_code
  # Read the input Swift file
  code = File.read(INPUT_FILE)
  annotated_code = ""
  start_idx = 0

  # Match each function in the code
  code.scan(FUNCTION_REGEX) do |match|
    function_start = $~.offset(0)[0]
    function_end = code.index('}', function_start) + 1 # Find the end of the function
    function_code = code[function_start...function_end]

    # Fetch documentation from llama3
    puts("fetch docs")
    documentation = fetch_documentation(function_code)
    if documentation
      annotated_code += "/// #{documentation}\n"
    end

    # Append the function to the annotated code
    annotated_code += function_code + "\n\n"
    start_idx = function_end
  end

  # Append remaining code
  annotated_code += code[start_idx..-1]

  # Save the annotated code
  File.write(OUTPUT_FILE, annotated_code)
  puts "Annotated cod :-- #{annotated_code} saved to #{OUTPUT_FILE}"
end

# Execute the script
puts("execute")
annotate_code
