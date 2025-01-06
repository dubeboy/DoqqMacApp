//
//  ChatInputView.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 06/01/2025.
//

import SwiftUI

struct ChatInputView: View {
    @State private var messageText: String = ""
    var onSend: (String) -> Void // Closure to handle sending the message

    var inputView: some View {
        HStack {
            TextField("Ask Doqq...", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .frame(height: 30)

            Button(action: {
                if !messageText.trimmingCharacters(in: .whitespaces).isEmpty {
                    onSend(messageText)
                    messageText = ""
                }
            }) {
                Text("Send")
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
            }
            .buttonStyle(PlainButtonStyle()) // For macOS, ensure buttons are styled explicitly
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 1)
    }

    var body: some View {
        inputView
    }
}

struct ChatInputView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInputView { message in
            print("Message sent: \(message)")
        }
        .frame(width: 400) // Add a width for macOS preview
    }
}
