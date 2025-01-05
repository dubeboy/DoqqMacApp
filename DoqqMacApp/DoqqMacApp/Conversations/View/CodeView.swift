//
//  CodeView.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 06/01/2025.
//

import SwiftUI
import WebKit

struct CodeView: View {
    let codeSnippet: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let detectedLanguage = detectLanguage(from: codeSnippet) {
                Text("Detected Language: \(detectedLanguage)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                CodeViewRepresentable(code: codeSnippet,
                                      language: detectedLanguage)
                .frame(height: 300) // Adjust height as needed
            } else {
                ScrollView(.horizontal) {
                    Text(codeSnippet)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.green)
                        .padding()
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
    }
    
    // Function to detect the language of the code snippet
    func detectLanguage(from code: String) -> String? {
        // Check for language in code fences
        if let languageMatch = code.range(of: "```([a-zA-Z0-9_+-]+)", options: .regularExpression) {
            let language = String(code[languageMatch])
                .replacingOccurrences(of: "```", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            return language.capitalized
        }
        
        // Fallback to heuristic-based detection
        let keywords: [String: [String]] = [
            "Swift": ["import Foundation", "func", "let", "var"],
            "Python": ["def", "import", "print", "self"],
            "JavaScript": ["function", "const", "let", "var"],
            "Java": ["public class", "static void", "import java"],
            "C++": ["#include", "std::", "int main()"],
            "HTML": ["<html>", "<body>", "<head>"],
            "CSS": ["color:", "background:", "font-size:"],
            "Kotlin": ["fun main", "val", "var", "import kotlin"]
        ]
        
        for (language, patterns) in keywords {
            if patterns.contains(where: { code.contains($0) }) {
                return language
            }
        }
        
        return nil
    }
    
}

struct CodeViewRepresentable: NSViewRepresentable {
    let code: String
    let language: String
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.setValue(false, forKey: "drawsBackground") // Make the background transparent
        return webView
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {
        let htmlTemplate = """
        <!DOCTYPE html>
        <html>
        <head>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/styles/default.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/highlight.min.js"></script>
            <script>hljs.highlightAll();</script>
            <style>
                body {
                    font-family: monospace;
                    font-size: 14px;
                    background-color: #f4f4f4;
                    padding: 16px;
                    border-radius: 8px;
                    overflow-x: auto;
                }
                pre {
                    background: #282c34;
                    color: #abb2bf;
                    padding: 12px;
                    border-radius: 8px;
                }
            </style>
        </head>
        <body>
        <pre><code class="\(language.lowercased())">\(code.htmlEscaped)</code></pre>
        </body>
        </html>
        """
        webView.loadHTMLString(htmlTemplate, baseURL: nil)
    }
}

extension String {
    // Escape special HTML characters
    var htmlEscaped: String {
        self.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
    }
}

struct CodeViewPreview: View {
    let exampleCode = """
    ```swift
    import Foundation
    
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    ```
    """
    
    var body: some View {
        CodeView(codeSnippet: exampleCode)
    }
}

#Preview {
    CodeViewPreview()
}
