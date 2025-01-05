//
//  DoqqViewModel.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftUI
import Foundation

@Observable
class DoqqViewModel {
    enum State {
        case loading, initLoaded([ConversationSessionModel]), initLoadFail, askingLLM, errorAskingLLM, successAskingLLM
    }
    
    private let conversationManager = ConversationManager()
    var state: State = .loading
    var sessions: [ConversationSessionModel] {
        conversationManager.sessions
    }
    
    func loadSessions() async {
        do {
            let sessions = try await conversationManager.loadSessions()
            state = .initLoaded(sessions)
        } catch {
            state = .initLoadFail
        }
    }
    
    func askDoqq(session id: Int, message: String) async {
        do {
            state = .askingLLM
            let response = try await conversationManager.askDoqq(session: id, message: Message(role: "user", content: message))
            state = .successAskingLLM
        } catch {
            state = .errorAskingLLM
        }
    }
}
