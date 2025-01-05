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
            Text("Chat View")
        }
    }
    
    var sideBar: some View {
        List(viewModel.sessions, selection: $viewModel.selectedSession) { session in
            Button {
                viewModel.selectSession(session: session.id)
            } label: {
                Text(session.name)
                    .padding()
            }
        }
    }
}


#Preview {
    ConversationsView()
}
