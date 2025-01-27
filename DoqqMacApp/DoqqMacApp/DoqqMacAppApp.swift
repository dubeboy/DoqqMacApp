//
//  DoqqMacAppApp.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftUI
import SwiftData

@main
struct DoqqMacAppApp: App {
    var body: some Scene {
        WindowGroup {
            ConversationsView()
        }
        .modelContainer(for: ConversationSessionModel.self, isAutosaveEnabled: false)
    }
}

