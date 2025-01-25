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
    
    func toPayload() -> Message {
        .init(role: role, content: content)
    }
}
