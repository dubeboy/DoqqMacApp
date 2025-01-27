//
//  Conversation.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation
import SwiftData

@Model
class ConversationSessionModel: Identifiable {
    @Attribute(.unique) var id: Int // Simple old increment by one ID, because why not
    var name: String
    var chatHistory: [Message]
    
    init(id: Int, name: String, chatHistory: [Message]) {
        self.id = id
        self.name = name
        self.chatHistory = chatHistory
    }
    
    static func addBidirection(session: ConversationSessionModel, messages: [Message]) -> Void {
        messages.forEach { message in
            message.session = session
        }
    }
}

struct ConversationSessionDTO {
    var id: Int
    var name: String
    var chatHistory: [Message]
}
