//
//  ConversationManager.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

class ConversationManager {
    private(set) var sessions: [ConversationSessionModel] = []
    private let conversationService = ConversationService()
    
    func askDoqq(session id: Int, message: Message) async throws -> OllamaResponse {
        if sessions.count <= id { // even if it fails to send eg network issue, that is fine as it will not be persisted to DB
            sessions.append(ConversationSessionModel(id: id, name: "New Chat \(id)", chatHistory: [message]))
        } else {
            sessions[id].chatHistory.append(message)
        }
        
        let response = try await conversationService.sendToLlama3(messages: sessions[id].chatHistory) // There is a problem
        sessions[id].chatHistory.append(response.message)
        // Save to local DB if this was successful
        return response
    }
    
    /// adds this session to local DB
    private func appendSessionToLocalDB(session: ConversationSessionModel) {
        
    }
    
    /// loads sessions from local store
    func loadSessions() async throws -> [ConversationSessionModel] {
        []
    }
    
    // New Chat \(id) is not cool , should use the llama to update this name to approriate name
    func updateChatName(for id: Int) async {
        
    }
}
