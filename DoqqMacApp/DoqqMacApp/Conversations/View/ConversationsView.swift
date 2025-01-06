//
//  ContentView.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftUI

struct ConversationsView: View {
    @State var viewModel = ConversationViewModel()
    
    var body: some View {
        NavigationView {
            sideBar
            chatView
        }
    }
    
    var chatView: some View {
        ZStack(alignment: .bottom) { // Align content to the bottom
            VStack {
                List {
                    ForEach(viewModel.selectedSessionMessages, id: \.id) { message in
                        HStack {
                            if message.isQuery {
                                Spacer() // Push the bubble to the right
                                RichResponseTextView(response: message.content)
                            } else {
                                RichResponseTextView(response: message.content)
                                Spacer() // Push the bubble to the left
                            }
                        }
                        .padding(.vertical, 4) // Add spacing between messages
                    }
                    
                    switch viewModel.state {
                    case .askingLLM:
                        HStack {
                            Spacer()
                            Text("Loading...")
                        }
                    default:
                        EmptyView()
                    }
                }
                .padding(.bottom, 90) // Ensure the list doesn't overlap the input view
            }

            ChatInputView { message in
                Task {
                    await viewModel.askDoqq(message: message)
                }
            }
            .padding()
        }
    }
    
    var sideBar: some View {
        List(viewModel.sessions, selection: $viewModel.selectedSession) { session in
            Text(session.name)
        }
    }
}


#Preview {
    ConversationsView()
}
