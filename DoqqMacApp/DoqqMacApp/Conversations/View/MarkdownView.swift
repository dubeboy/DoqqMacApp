//
//  MarkdownView.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 27/01/2025.
//


import SwiftUI
import WebKit
import MarkdownUI
import Splash


struct MarkdownView: View {
    let text: String
    var body: some View {
        Markdown {
            text
        }
        .markdownBlockStyle(\.codeBlock) {
          codeBlock($0)
        }
        .markdownCodeSyntaxHighlighter(.splash(theme: self.theme))
        .markdownTextStyle(\.emphasis) {
          FontStyle(.italic)
          UnderlineStyle(.single)
        }
        .markdownTextStyle(\.strong) {
          FontWeight(.heavy)
        }
        .markdownTextStyle(\.strikethrough) {
          StrikethroughStyle(.init(pattern: .solid, color: .red))
        }
        .markdownTextStyle(\.link) {
          ForegroundColor(.mint)
          UnderlineStyle(.init(pattern: .dot))
        }
        .markdownTextStyle(\.code) {
            BackgroundColor(.green.opacity(0.5))
        }
        .markdownTextStyle(\.text) {
            ForegroundColor(.text)
            BackgroundColor(.background)
            FontSize(16)
        }
        .padding()
    }
    
    @ViewBuilder
    private func codeBlock(_ configuration: CodeBlockConfiguration) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(configuration.language ?? "plain text")
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(theme.plainTextColor))
                Spacer()
                
                Image(systemName: "clipboard")
                    .onTapGesture {
                        copyToClipboard(configuration.content)
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                Color(theme.backgroundColor)
            }
            
            Divider()
            
            ScrollView(.horizontal) {
                configuration.label
                    .relativeLineSpacing(.em(0.25))
                    .markdownTextStyle {
                        FontFamilyVariant(.monospaced)
                        FontSize(.em(0.85))
                    }
                    .padding()
            }
        }
        .background(Color(.black))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .markdownMargin(top: .zero, bottom: .em(0.8))
    }
    
    private var theme: Splash.Theme {
        // NOTE: We are ignoring the Splash theme font
        
        return .wwdc18(withFont: .init(size: 18))
        //      switch self.colorScheme {
        //      case .dark:
        //
        //      default:
        //        return .sunset(withFont: .init(size: 16))
        //      }
    }
    
    private func copyToClipboard(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
    }
}

extension SwiftUI.Color {
  fileprivate static let text = Color(
    light: Color(rgba: 0x0606_06ff), dark: Color(rgba: 0xfbfb_fcff)
  )
  fileprivate static let secondaryText = Color(
    light: Color(rgba: 0x6b6e_7bff), dark: Color(rgba: 0x9294_a0ff)
  )
  fileprivate static let tertiaryText = Color(
    light: Color(rgba: 0x6b6e_7bff), dark: Color(rgba: 0x6d70_7dff)
  )
  fileprivate static let background = Color(
    light: .white, dark: Color(rgba: 0x1819_1dff)
  )
  fileprivate static let secondaryBackground = Color(
    light: Color(rgba: 0xf7f7_f9ff), dark: Color(rgba: 0x2526_2aff)
  )
  fileprivate static let link = Color(
    light: Color(rgba: 0x2c65_cfff), dark: Color(rgba: 0x4c8e_f8ff)
  )
  fileprivate static let border = Color(
    light: Color(rgba: 0xe4e4_e8ff), dark: Color(rgba: 0x4244_4eff)
  )
  fileprivate static let divider = Color(
    light: Color(rgba: 0xd0d0_d3ff), dark: Color(rgba: 0x3334_38ff)
  )
  fileprivate static let checkbox = Color(rgba: 0xb9b9_bbff)
  fileprivate static let checkboxBackground = Color(rgba: 0xeeee_efff)
}

struct MarkdownContentView: View {
    let markdownContent = """
    # Welcome to Markdown Viewer with Copyable Code Blocks
    
    This Markdown is rendered using **Marked.js** and **Prism.js** for syntax highlighting.
    
    ## Features:
    - **Markdown Rendering**
    - Syntax Highlighting for Code Blocks
    - Copy to Clipboard Button for Code Blocks
    
    ### Example Code Block:
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        var body: some View {
            Text("Hello, World!")
        }
    }
    ```
    """
    
    var body: some View {
        MarkdownView(text: markdownContent)
            .frame(height: 300)
    }
}

struct SplashCodeSyntaxHighlighter: CodeSyntaxHighlighter {
  private let syntaxHighlighter: SyntaxHighlighter<TextOutputFormat>

  init(theme: Splash.Theme) {
    self.syntaxHighlighter = SyntaxHighlighter(format: TextOutputFormat(theme: theme))
  }

  func highlightCode(_ content: String, language: String?) -> Text {
    guard language != nil else {
      return Text(content)
    }

    return self.syntaxHighlighter.highlight(content)
  }
}

extension CodeSyntaxHighlighter where Self == SplashCodeSyntaxHighlighter {
  static func splash(theme: Splash.Theme) -> Self {
    SplashCodeSyntaxHighlighter(theme: theme)
  }
}

struct TextOutputFormat: OutputFormat {
    private let theme: Splash.Theme

    init(theme: Splash.Theme) {
    self.theme = theme
  }

  func makeBuilder() -> Builder {
    Builder(theme: self.theme)
  }
}

extension TextOutputFormat {
  struct Builder: OutputBuilder {
      private let theme: Splash.Theme
    private var accumulatedText: [Text]

      fileprivate init(theme: Splash.Theme) {
      self.theme = theme
      self.accumulatedText = []
    }

    mutating func addToken(_ token: String, ofType type: TokenType) {
      let color = self.theme.tokenColors[type] ?? self.theme.plainTextColor
      self.accumulatedText.append(Text(token).foregroundColor(.init(color)))
    }

    mutating func addPlainText(_ text: String) {
      self.accumulatedText.append(
        Text(text).foregroundColor(.init(self.theme.plainTextColor))
      )
    }

    mutating func addWhitespace(_ whitespace: String) {
      self.accumulatedText.append(Text(whitespace))
    }

    func build() -> Text {
      self.accumulatedText.reduce(Text(""), +)
    }
  }
}



#Preview {
    MarkdownContentView()
}


