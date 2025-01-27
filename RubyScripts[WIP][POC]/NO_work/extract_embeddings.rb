require 'json'

# Load the AST JSON
ast = JSON.parse(File.read("ast.json"))

# Read the original source file
source_code = File.read("./Combined.swift")

# Recursively extract functions from the AST
def extract_functions(ast_node)
  return [] unless ast_node.is_a?(Hash) && ast_node["key.substructure"]

  functions = []
  ast_node["key.substructure"].each do |item|
    # Check if the node is a function (free, instance, or static)
    if ["source.lang.swift.decl.function.free",
        "source.lang.swift.decl.function.method.instance",
        "source.lang.swift.decl.function.method.static"].include?(item["key.kind"])
      functions << item
    end

    # Recurse into substructures
    functions.concat(extract_functions(item))
  end

  functions
end

# Correct offsets dynamically
def adjust_offset(source_code, target_offset, target_length)
  current_offset = 0
  current_index = 0

  # Traverse the source code character-by-character
  source_code.each_char.with_index do |char, index|
    # Skip characters that don't count toward the offset (e.g., UTF-8 handling)
    current_offset += char.bytesize
    current_index = index
    break if current_offset >= target_offset
  end

  # Extract the source text
  adjusted_text = source_code[current_index, target_length]
  adjusted_text
end

# Extract functions from the top-level AST
functions = extract_functions(ast)

# Collect function chunks and additional metadata
function_chunks = functions.map do |func|
  offset = func["key.offset"]
  length = func["key.length"]

  # Adjust the offset and extract source text
  source_text = offset && length ? adjust_offset(source_code, offset, length) : nil

  {
    name: func["key.name"],
    kind: case func["key.kind"]
          when "source.lang.swift.decl.function.free" then "Free Function"
          when "source.lang.swift.decl.function.method.instance" then "Instance Method"
          when "source.lang.swift.decl.function.method.static" then "Static Method"
          else "Unknown"
          end,
    offset: offset,
    length: length,
    sourcetext: source_text
  }
end

# Write the function chunks to a JSON file
File.write("function_chunks.json", JSON.pretty_generate(function_chunks))
puts "Function chunks have been written to 'function_chunks.json'"
