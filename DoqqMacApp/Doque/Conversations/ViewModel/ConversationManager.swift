//
//  ConversationManager.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftData
import Foundation

/// Conversation manager and data amanger for the viewmodel
final class ConversationManager {
    private(set) var sessions: [ConversationSessionDTO] = []
    private let conversationService = ConversationService()
    @LateInitialized
    private var modelContext: ModelContext
    
    func askDoqq(session id: Int, modelName: String, name: String, message: Message) async throws -> OllamaResponse {
        if sessions.count <= id { // even if it fails to send eg network issue, that is fine as it will not be persisted to DB
            let session = ConversationSessionDTO(id: id, name: name, modelName: modelName, chatHistory: [message])
            sessions.append(session)
        } else {
            sessions[id].chatHistory.append(message)
        }
        
        let response = try await conversationService.sendToLlama3(messages: sessions[id].chatHistory) // There is a problem
        sessions[id].chatHistory.append(response.message)
        try appendSessionToLocalDB(id: id, modelName: modelName, name: name, messages: [message, response.message])
        return response
    }
    
    /// adds this session to local DB
//    @MainActor
    func appendSessionToLocalDB(id: Int, modelName: String, name: String, messages: [Message]) throws {
       try modelContext.transaction {
           let predicate = #Predicate<ConversationSessionModel> { session in
               session.id == id
           }
           
           let fetchDescriptor = FetchDescriptor<ConversationSessionModel>(predicate: predicate)
           if let session = try modelContext.fetch(fetchDescriptor).first {
               ConversationSessionModel.addBidirection(session: session, messages: messages)
               session.chatHistory.append(contentsOf: messages)
           } else {
               let session = ConversationSessionModel(id: id, modelName: modelName, name: name, chatHistory: messages)
               ConversationSessionModel.addBidirection(session: session, messages: messages)
               modelContext.insert(session)
           }
           try modelContext.save()
        }
    }
    
//    @MainActor
//     func saveBatch() throws {
//        try modelContext.save()
//    }
    
    
//    @MainActor
    func findSession(for id: Int) throws -> ConversationSessionModel? {
        let predicate = #Predicate<ConversationSessionModel> { session in
            session.id == id
        }
        let fetchDescriptor = FetchDescriptor<ConversationSessionModel>(predicate: predicate)
        let session = try modelContext.fetch(fetchDescriptor).first
        
        return session
    }
    
    /// loads sessions from local store
    /// sets the context
//    @MainActor
    func loadSessions(with context: ModelContext) throws {
        self.modelContext = context
        let fetchDescriptor = FetchDescriptor<ConversationSessionModel>(sortBy: [ SortDescriptor(\.id, order: .reverse) ])
        let sessions = try modelContext.fetch(fetchDescriptor)
        if self.sessions.isEmpty {
            self.sessions = sessions.map({ model in
                    .init(id: model.id, name: model.name, modelName: model.modelName, chatHistory: model.chatHistory)
            })
        }
    }
    
    // New Chat \(id) is not cool , should use the llama to update this name to approriate name
    func updateChatName(for id: Int) async {
        
    }
}
