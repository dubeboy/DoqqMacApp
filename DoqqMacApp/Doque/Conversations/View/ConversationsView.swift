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
    @State var viewModel: ConversationViewModel = ConversationViewModel()
    
    var body: some View {
        NavigationView {
            sideBar
            chatView
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                newSessionToolBarItem
            }
        }
        .onAppear {
            Task {
                await viewModel.loadSessions(with: modelContext)
            }
        }
    }
    
    private func selectFolder(model: StateModel) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        
        if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
            let selectedFolderPath = selectedURL.path
            Task {
                await viewModel.processFiles(model: model, cocoapodsRoot: selectedFolderPath)
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
    
    var newSessionToolBarItem: some View {
        Group {
            if case viewModel.state = .ollamaNotRunning {
                Button {
                    Task {
                        await viewModel.loadSessions(with: modelContext)
                    }
                } label: {
                    HStack {
                        Text("Try Again")
                        Image(systemName: "arrow.trianglehead.counterclockwise") // Icon for the sidebar toggle
                                                .help("Toggle sidebar")
                    }
                   
                }
                .buttonStyle(BorderlessButtonStyle())
            } else {
                Menu {
                    ForEach(viewModel.installedModels, id: \.id) { model in
                        Button("New \(model.name) Session", action: {
                            selectFolder(model: model)
                        })
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedModel)
                    }
                }
                .menuStyle(BorderlessButtonMenuStyle())
                .disabled(viewModel.disableInteraction)
            }
        }
    }
}


#Preview {
    ConversationsView()
}
