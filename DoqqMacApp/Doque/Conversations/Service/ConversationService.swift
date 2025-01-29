//
//  ConversationsService.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation

final class ConversationService {
    enum ConversationEndpoint: EndpointProtocol {
        case chat([Message]), localModels
        var path: String {
            switch self {
            case .chat:
                "api/chat"
            case .localModels:
                "api/tags"
            }
        }
        var method: HTTPMethod {
            switch self {
            case .chat:
                return .post
            case .localModels:
                return .get
            }
        }
        var body: Encodable? {
            switch self {
            case .chat(let messages):
                return OllamaPayload(model: "llama3", messages: messages, stream: false)
            case .localModels:
                return nil
            }
        }
    }
    
    private let service = DoqqHTTPServiceClient.shared
    
    func sendToLlama3(messages: [Message]) async throws -> OllamaResponse {
        return try await service.makeRequest(ConversationEndpoint.chat(messages), for: OllamaResponse.self)
    }
    
    func ollamaListLocalModels() async throws -> OllamaModelResponse {
        return try await service.makeRequest(ConversationEndpoint.localModels, for: OllamaModelResponse.self)
    }
}
