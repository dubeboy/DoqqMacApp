require 'net/http'
require 'uri'
require 'json'
require 'find'

# Constants
PRIME_AGENT_INSTRUCTIONS = "From now on I want you to be an agent that acts as my smart code documentation search agent such that I can search and check if certain or similar code exists in my library and in a natural language way, for example: 'Code that can change the UINavigationBar to Green' and it should be able to reference from the previously shared code in which such similar code exists. I will send/share with the code to reference from in following prompts in chunks and you should only be ready to receive search queries once I send the end signal which is: !END!"
LLAMA3_API_ENDPOINT = "http://localhost:11434/api/chat" # Update to your actual Llama3 endpoint
END_SIGNAL = "!END!" # Update to your actual Llama3 endpoint
MODEL_NAME = "llama3" # Update to your actual Llama3 endpoint
SOURCE_ROOT = "/Users/divinedube/Developer/Self/Doqq/TestPod" # Default source root directory

# Global variable to store conversation history
@conversation_history = []

# Function to send data to Llama3
def send_to_llama3(endpoint, message, role = "user")
#   print("\n\n Sending... #{message}")
  uri = URI.parse(endpoint)
  http = Net::HTTP.new(uri.host, uri.port)

  # Add the message to the conversation history with the specified role
  @conversation_history << { role: role, content: message }

  # Prepare the request body with the full conversation history
  request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
  request.body = {
    model: MODEL_NAME,
    messages: @conversation_history,
    stream: false
  }.to_json

#   print("\n\n body... #{request.body}")

  response = http.request(request)
  if response.code.to_i == 200
    begin
      result = JSON.parse(response.body)
    #   puts("\n\n #{result}")
      assistant_reply = result.dig("message", "content") || ""
      # Add the assistant's reply to the conversation history
      @conversation_history << { role: role, content: assistant_reply }
      return assistant_reply
    rescue JSON::ParserError
      puts "\n\nError parsing response: #{response.body}"
      return nil
    end
  else
    puts "\n\nError querying Ollama: #{response.code} - #{response.body}"
    return nil
  end
end

# Function to crawl through files and send them to Llama3
def process_files(cocoapods_root)
  print(" \n\nPrime the Llama3 agent")
  send_to_llama3(LLAMA3_API_ENDPOINT, PRIME_AGENT_INSTRUCTIONS)

  chunk_index = 0

  Find.find(cocoapods_root) do |path|
    next if File.directory?(path) # Skip directories

    begin
      file_content = File.read(path)
      file_name = File.basename(path)
      relative_path = path.sub(cocoapods_root, '')
    #   print("\n\nfound file #{file_name}")

      # Prepare the payload
      payload = {
        file_name: file_name,
        relative_path: relative_path,
        content: file_content
      }

    #   print("\n\nsending payload #{payload.to_json}")
      chunk_index += 1
      # Send the file content to Llama3
      send_to_llama3(LLAMA3_API_ENDPOINT, "Here is code chunk number: #{chunk_index}, chunk: #{payload.to_json}")
    rescue => e
    #   puts "Error reading or sending file #{path}: #{e.message}"
    end
  end
#   puts("\n\nsending end chunk")
end

# Main Execution
if __FILE__ == $0
  cocoapods_root = ARGV[0] || SOURCE_ROOT

  unless Dir.exist?(cocoapods_root)
    puts "Error: Directory #{cocoapods_root} does not exist."
    exit 1
  end

  process_files(cocoapods_root)

  send_to_llama3(LLAMA3_API_ENDPOINT, END_SIGNAL)
#   print("\n\nCONVS #{@conversation_history}")
  # Interactive REPL
  loop do
    print "\nEnter your query (or type 'exit' to quit): "
   
    user_input = gets.strip
    break if user_input.downcase == 'exit'

    response = send_to_llama3(LLAMA3_API_ENDPOINT, user_input, "user")
    puts "\nResponse: #{response}"
  end
end
process_files(SOURCE_ROOT)

# r1 = send_to_llama3(LLAMA3_API_ENDPOINT, { query: "Is there a function that can add two numbers in any of the code chunks I sent" })
# r2 = send_to_llama3(LLAMA3_API_ENDPOINT, { query: "Is there a function that can divide two numbers in any of the code chunks I sent?" })
# puts("\n\n r1")
# puts("\n\n r2 #{r2}")