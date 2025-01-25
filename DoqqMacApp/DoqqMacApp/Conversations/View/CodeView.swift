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
            if let detectedLanguage = detectLanguage(from: codeSnippet),
               let extractedCode = extractCode(from: codeSnippet) {
                Text("Detected Language: \(detectedLanguage.capitalized)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                CodeViewRepresentable(code: extractedCode,
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
        .padding()
    }
    
    // Function to detect the language of the code snippet
    func detectLanguage(from code: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "```([a-zA-Z0-9_+-]+)")
        if let match = regex.firstMatch(in: code, range: NSRange(code.startIndex..., in: code)) {
            if let range = Range(match.range(at: 1), in: code) {
                return String(code[range])
            }
        }
        return nil
    }
    
    // Function to extract the code block from the snippet
    func extractCode(from code: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "```[a-zA-Z0-9_+-]+\\n([\\s\\S]+)```", options: [])
        if let match = regex.firstMatch(in: code, range: NSRange(code.startIndex..., in: code)) {
            if let range = Range(match.range(at: 1), in: code) {
                return String(code[range]).trimmingCharacters(in: .whitespacesAndNewlines)
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
                    background-color: #000;
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
                        \(code.htmlEscaped)
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
