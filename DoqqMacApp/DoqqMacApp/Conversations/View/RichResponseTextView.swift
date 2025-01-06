//
//  RichResponseTextView.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 06/01/2025.
//

import SwiftUI
import WebKit

struct RichResponseTextView: View {
    let response: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Split the response into lines to parse
                ForEach(parseResponse(response), id: \.self) { element in
                    switch element {
                    case .text(let content):
                        Text(content)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                    case .file(let fileName, let filePath):
                        VStack(alignment: .leading, spacing: 4) {
                            Text("File: \(fileName)")
                                .font(.headline)
                                .padding()
                            Button(action: {
                                openFileManager(at: filePath)
                            }) {
                                Text(filePath)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                        .padding(.vertical, 4)
                    case .code(let content):
                        CodeView(codeSnippet: content)
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
    }

    // Helper function to parse the response
    func parseResponse(_ response: String) -> [ResponseElement] {
        var elements: [ResponseElement] = []
        let lines = response.split(separator: "\n")

        for line in lines {
            if line.contains("{\"file_name\"") {
                if let jsonStartIndex = line.range(of: "{"),
                   let jsonString = line[jsonStartIndex.lowerBound...].data(using: .utf8),
                   let fileChunk = try? JSONDecoder().decode(FileChunk.self, from: jsonString) {
                    elements.append(.file(fileName: fileChunk.fileName, filePath: fileChunk.relativePath))
                }
            } else if line.contains("```") {
                // Assume lines between triple backticks are code
                elements.append(.code(content: String(line)))
            } else {
                elements.append(.text(content: String(line)))
            }
        }

        return elements
    }

    // Open File Manager (placeholder implementation)
    func openFileManager(at path: String) {
        // Implement your file opening logic here
        print("Opening file manager for path: \(path)")
    }
}

// Enum to define different types of response elements
enum ResponseElement: Hashable {
    case text(content: String)
    case file(fileName: String, filePath: String)
    case code(content: String)
}

// Codable struct for file chunk
struct FileChunk: Codable {
    let fileName: String
    let relativePath: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case relativePath = "relative_path"
        case content
    }
}


// Example usage
struct ContentView: View {
    let exampleResponse = """
    Response: I'm excited to help you with searching for code snippets.

    Based on the code snippet you've shared so far:

    * Chunk 1: {"file_name":"test.swift","relative_path":"/Sources/test.swift","content":"import Foundation\n\nfunc add(a: Int, b: Int) -> Int {\n    return a + b\n}"}

    Yes, your library has functionality to add two numbers together. In fact, you've already shared this code snippet in the first chunk!

    Here's the summary of what I've stored so far:

    * Chunk 1: {"file_name":"test.swift","relative_path":"/Sources/test.swift","content":"import Foundation\n\nfunc add(a: Int, b: Int) -> Int {\n    return a + b\n}"}

    Please proceed with your search queries in natural language. Ask me something like "Code that can [insert action or functionality]" and I'll do my best to find similar code snippets from what you've shared so far!

    What's your next question?
    """

    var body: some View {
        RichResponseTextView(response: exampleResponse)
    }
}

#Preview {
    ContentView()
}
