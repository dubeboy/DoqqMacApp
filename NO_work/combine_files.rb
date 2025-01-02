require 'fileutils'

def crawl_and_combine(source_dir, output_file)
  combined_content = []

  # Traverse the directory recursively
  Dir.glob("#{source_dir}/**/*.swift").each do |file|
    begin
      # Read the content of each Swift file
      content = File.read(file)
      combined_content << "// --- Start of: #{file} ---"
      combined_content << content
      combined_content << "// --- End of: #{file} ---\n"
    rescue => e
      puts "Error reading #{file}: #{e.message}"
    end
  end

  # Write the combined content to the output file
  begin
    File.write(output_file, combined_content.join("\n"))
    puts "Combined file created at: #{output_file}"
  rescue => e
    puts "Error writing to #{output_file}: #{e.message}"
  end
end

# Specify the directory and output file
source_directory = "/Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources" # Update this to your Sources directory path
output_filename = "./Combined.swift" # Output file path

# Run the function
crawl_and_combine(source_directory, output_filename)
