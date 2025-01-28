//
//  ConversationsService.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation

final class ConversationService {
    enum ConversationEndpoint: EndpointProtocol {
        case chat([Message])
        var path: String {
            "api/chat"
        }
        var method: HTTPMethod { .post }
        var body: Encodable? {
            switch self {
            case .chat(let messages):
                return OllamaPayload(model: "llama3", messages: messages, stream: false)
            }
        }
    }

    private let service = DoqqHTTPServiceClient.shared
    
    func sendToLlama3(messages: [Message]) async throws -> OllamaResponse {
//        print("Messages count \(messages.count)")
//        dump(messages)
        return try await service.makeRequest(ConversationEndpoint.chat(messages), for: OllamaResponse.self)
    }
}
