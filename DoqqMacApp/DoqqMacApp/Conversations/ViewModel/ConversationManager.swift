//
//  ConversationManager.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftData
import Foundation

/// Conversation manager and data amanger for the viewmodel
class ConversationManager {
    private(set) var sessions: [ConversationSessionModel] = []
    private let conversationService = ConversationService()
    @LateInitialized
    private var modelContext: ModelContext
    
    func askDoqq(session id: Int, name: String, message: Message) async throws -> OllamaResponse {
        if sessions.count <= id { // even if it fails to send eg network issue, that is fine as it will not be persisted to DB
            sessions.append(ConversationSessionModel(id: id, name: name, chatHistory: [message]))
        } else {
            sessions[id].chatHistory.append(message)
        }
        
        let response = try await conversationService.sendToLlama3(messages: sessions[id].chatHistory) // There is a problem
        sessions[id].chatHistory.append(response.message)
        try appendSessionToLocalDB(id: id, name: name, messages: [message, response.message])
        return response
    }
    
    /// adds this session to local DB
    private func appendSessionToLocalDB(id: Int, name: String, messages: [Message]) throws {
        
        let predicate = #Predicate<ConversationSessionModel> { session in
           session.id == id
        }
        
        let fetchDescriptor = FetchDescriptor<ConversationSessionModel>(predicate: predicate)
        if let session = try modelContext.fetch(fetchDescriptor).first {
            messages.forEach { message in
                message.session = session
            }
            session.chatHistory.append(contentsOf: messages)
        } else {
            modelContext.insert(ConversationSessionModel(id: id, name: name, chatHistory: messages))
        }
        
                if modelContext.hasChanges {
                    try modelContext.save()
                }
       

    }
    
    /// loads sessions from local store
    /// sets the context
    func loadSessions(with context: ModelContext) throws {
        self.modelContext = context
        let fetchDescriptor = FetchDescriptor<ConversationSessionModel>()
        let sessions = try modelContext.fetch(fetchDescriptor)
        self.sessions = sessions
    }
    
    // New Chat \(id) is not cool , should use the llama to update this name to approriate name
    func updateChatName(for id: Int) async {
        
    }
}
