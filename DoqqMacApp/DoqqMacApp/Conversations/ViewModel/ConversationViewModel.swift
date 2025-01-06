//
//  DoqqViewModel.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftUI
import Foundation

@Observable
class ConversationViewModel {
    enum State {
        case loading, initLoaded([ConversationSessionModel]), initLoadFail, askingLLM, errorAskingLLM, successAskingLLM
    }
    
    private let conversationManager = ConversationManager()
    var state: State = .loading
    var selectedSession: Int = 0
    var sessions: [ConversationSessionModel] {
        conversationManager.sessions
    }
    
    var selectedSessionMessages: [Message] {
        guard conversationManager.sessions.count > 0  else {
            return []
        }
        return conversationManager.sessions[selectedSession].chatHistory
    }
    
    func loadSessions() async {
        do {
            let sessions = try await conversationManager.loadSessions()
            state = .initLoaded(sessions)
        } catch {
            state = .initLoadFail
        }
    }
    
    func askDoqq(message: String) async {
        do {
            state = .askingLLM
            let _ = try await conversationManager.askDoqq(session: selectedSession, message: Message(role: "user", content: message, isQuery: true))
            state = .successAskingLLM
        } catch {
            state = .errorAskingLLM
        }
    }
    
    func selectSession(session id: Int) {
        selectedSession = id
    }
    
}
