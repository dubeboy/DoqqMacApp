//
//  Conversation.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation

struct ConversationSessionModel: Identifiable {
    let id: Int // Simple old increment by one ID, because why not
    let name: String
    var chatHistory: [Message]
}
