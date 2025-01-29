//
//  ConversationSessionStateModel.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 06/01/2025.
//

import Foundation

struct MessageStateModel: Identifiable {
    var id: String = UUID().uuidString
    
    let role: String
    let content: String
    var isQuery: Bool = false
    var isEnd: Bool = false
    
    func toPayload() -> Message {
        .init(role: role, content: content, isQuery: isQuery, isEnd: isEnd)
    }
    
    init(role: String, content: String, isQuery: Bool) {
        self.role = role
        self.content = content
        self.isQuery = isQuery
    }
    
    init(message: Message) {
        self.init(role: message.role, content: message.content, isQuery: message.isQuery)
    }
}
