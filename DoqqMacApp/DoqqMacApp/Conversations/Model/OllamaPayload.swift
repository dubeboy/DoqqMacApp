//
//  OllamaPayload.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation
import SwiftData

struct OllamaPayload: Codable {
    let model: String
    let messages: [Message]
    let stream: Bool
}

@Model
class Message: Codable, Identifiable {
    @Attribute(.unique) var id: String
    var role: String
    var content: String
    var isQuery: Bool
    var isEnd: Bool  // Clearly indicates the end of the prime process so that we can ommit all the prime messages
    
    // Inverse relationship to ConversationSessionModel
    var session: ConversationSessionModel?
    
    enum CodingKeys: String, CodingKey {
        case role, content
    }
    
    init(role: String, content: String, isQuery: Bool, isEnd: Bool = false) {
        self.role = role
        self.content = content
        self.id = UUID().uuidString
        self.isQuery = isQuery
        self.isEnd = isEnd
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.role = try container.decode(String.self, forKey: .role)
        self.content = try container.decode(String.self, forKey: .content)
        self.id = UUID().uuidString
        self.isEnd = false
        self.isQuery = false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role, forKey: .role)
        try container.encode(content, forKey: .content)
    }
}
