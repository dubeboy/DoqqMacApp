//
//  ContentView.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftUI
import SwiftData
//import MarkD

struct ConversationsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: ConversationViewModel = ConversationViewModel() // it being being nil is a problem we could make modelContext nullable in the viewmodel instead
    
    var body: some View {
        NavigationView {
            sideBar
            chatView
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: selectFolder) {
                    Image(systemName: "plus")
                        .help("Select a folder")
                }
                .buttonStyle(BorderlessButtonStyle())
                .disabled(viewModel.disableInteraction)
            }
        }
        .onAppear {
            viewModel.loadSessions(with: modelContext)
        }
    }
    
    private func selectFolder() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        
        if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
            let selectedFolderPath = selectedURL.path
            print("Selected folder: \(selectedFolderPath)")
            Task {
                await viewModel.processFiles(cocoapodsRoot: selectedFolderPath)
            }
        }
    }
    
    var chatView: some View {
        ZStack(alignment: .bottom) { // Align content to the bottom
            VStack {
                List {
                    ForEach(viewModel.selectedSessionMessages, id: \.id) { message in
                        HStack {
                            if message.isQuery {
                                Spacer()
                                MarkdownView(text: message.content)
                            } else {
                                MarkdownView(text: message.content)
                                Spacer()
                            }
                        }
                        .padding(.vertical, 4)
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
            
            ChatInputView(disabled: viewModel.disableInteraction) { message in
                Task {
                    await viewModel.askDoqq(message: message)
                }
            }
            .padding()
        }
    }
    
    var sideBar: some View {
        List(viewModel.sessions, id: \.id, selection: $viewModel.selectedSession) { session in
            Text(session.name)
        }
        .disabled(viewModel.disableInteraction)
    }
}


#Preview {
    ConversationsView()
}
