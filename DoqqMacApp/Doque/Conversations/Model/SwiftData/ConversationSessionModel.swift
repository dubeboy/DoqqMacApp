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
    var modelName: String
    var chatHistory: [Message]
    
    init(id: Int, modelName: String, name: String, chatHistory: [Message]) {
        self.id = id
        self.name = name
        self.modelName = modelName
        self.chatHistory = chatHistory
    }
    
    static func addBidirection(session: ConversationSessionModel, messages: [Message]) -> Void {
        let count = session.chatHistory.count
        messages.enumerated().forEach { index, message in
            message.id = index + count
            message.session = session
        }
    }
}

struct ConversationSessionDTO {
    var id: Int
    var name: String
    var modelName: String
    var chatHistory: [Message]
}
