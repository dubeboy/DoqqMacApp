//
//  OllamaPayload.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation

struct OllamaPayload: Codable {
    let model: String
    let messages: [Message]
    let stream: Bool
}

struct Message: Codable, Identifiable {
    var id: String = UUID().uuidString
    
    let role: String
    let content: String
    var isQuery: Bool = false
}
