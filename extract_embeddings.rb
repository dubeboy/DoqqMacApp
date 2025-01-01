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

# Extract functions from the top-level AST
functions = extract_functions(ast)

# Print function details and source code
functions.each do |func|
  # Determine the kind of function
  kind = case func["key.kind"]
         when "source.lang.swift.decl.function.free" then "Free Function"
         when "source.lang.swift.decl.function.method.instance" then "Instance Method"
         when "source.lang.swift.decl.function.method.static" then "Static Method"
         else "Unknown"
         end

  # Extract source code using offset and length
  offset = func["key.offset"]
  length = func["key.length"]

  if offset && length
    source = source_code[offset, length]
    puts "Function: #{func['key.name']}"
    puts "Kind: #{kind}"
    puts "Source: #{source}"
    puts "---"
  else
    puts "Function: #{func['key.name']} (Kind: #{kind}) has invalid offset or length."
    puts "---"
  end
end
