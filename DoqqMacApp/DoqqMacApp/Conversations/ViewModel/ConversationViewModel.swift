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
        case loading, initLoaded, initLoadFail, askingLLM, errorAskingLLM, successAskingLLM
    }
    
    private let conversationManager = ConversationManager()
    private let primeMessage = "From now on, you are my ‘Smart Code Documentation Search Agent.’ You will help me search and check if certain or similar code exists in my library using natural language queries. For example, if I ask: ‘Code that can change the UINavigationBar to Green,’ you should respond with any relevant code from my previously shared library. The library code will be provided to you in subsequent prompts in JSON format, with the keys ‘filename’, ‘relativePath’, and ‘content’ (the actual code). You must not answer any code search queries until I explicitly send the end signal ‘END_CHUNK_SEND’. Once you receive this signal, you may answer queries by referencing the appropriate chunk index in Markdown format if relevant code exists. If no relevant code is found, simply state that nothing matches the query."
    var state: State = .loading
    var selectedSession: Int = 0
    var numErrorWhenSendingChunks: Int = 0
    var sessions: [ConversationSessionModel] {
        conversationManager.sessions
    }
    
    var selectedSessionMessages: [MessageStateModel] = []
    
    func loadSessions() async {
        do {
            let _ = try await conversationManager.loadSessions()
            state = .initLoaded
        } catch {
            state = .initLoadFail
        }
    }
    
    func askDoqq(message: String) async {
        do {
            state = .askingLLM
            let message = MessageStateModel(role: "user", content: message, isQuery: true)
            selectedSessionMessages.append(message)
            let response = try await conversationManager.askDoqq(session: selectedSession, message: message.toPayload())
            selectedSessionMessages.append(.init(role: response.message.role, content: response.message.content))
            state = .successAskingLLM
        } catch {
            state = .errorAskingLLM
        }
    }
    
    func selectSession(session id: Int) {
        selectedSession = id
        // change this variable data to the data of this session `selectedSessionMessages`
    }
    
    func processFiles(cocoapodsRoot: String) async {
        print("\n\nPrime the Llama3 agent")
        selectedSessionMessages = [.init(role: "user", content: "Prime the Llama3 agent", isQuery: true)]
        var chunkIndex = 0
        state = .askingLLM
        do {
            // Send prime instructions to Llama3
            let _ = try await conversationManager.askDoqq(session: selectedSession, message: Message(role: "user", content: primeMessage))
            selectedSessionMessages.append(.init(role: "user", content: "Ok. Success Prime LLama agent"))
            
            let fileManager = FileManager.default
            let enumerator = fileManager.enumerator(atPath: cocoapodsRoot)
            selectedSessionMessages.append(.init(role: "user", content: "Priming for dir \(cocoapodsRoot)"))
                    
            while let path = enumerator?.nextObject() as? String {
                let fullPath = "\(cocoapodsRoot)/\(path)"
                guard fileManager.fileExists(atPath: fullPath), !fileManager.isDirectory(atPath: fullPath) else { continue }
                
                do {
                    let fileContent = try String(contentsOfFile: fullPath, encoding: .utf8)
                    let fileName = URL(fileURLWithPath: fullPath).lastPathComponent
                    let relativePath = fullPath.replacingOccurrences(of: cocoapodsRoot, with: "")
                    
                    // Prepare the payload
                    let payload = [
                        "file_name": fileName,
                        "relative_path": relativePath,
                        "content": fileContent
                    ]
                    
                    chunkIndex += 1
                    let message = Message(
                        role: "user",
                        content: "\(payload)"
                    )
                    
                    let response = try await conversationManager.askDoqq(session: selectedSession, message: message)
                    print("### PRIME")
                    dump(response)
                } catch {
                    numErrorWhenSendingChunks += 1
                    print("Error reading or sending file \(fullPath): \(error)")
                }
            }
            
            if numErrorWhenSendingChunks == 0 {
                selectedSessionMessages.append(.init(role: "user", content: "Primed \(chunkIndex) files"))
                print("### Success OPRime")
                await askDoqq(message: "_END_CHUNK_SEND_")
                state = .initLoaded
            } else {
                selectedSessionMessages.append(.init(role: "user", content: "Some code failed to be primed"))
                print("### Fail OPRime")
               
                state = .initLoadFail
            }
        } catch {
            selectedSessionMessages.append(.init(role: "user", content: "Something went wrong is Ollama running?"))
            state = .initLoadFail
            
        }
        print("\n\nFinished processing files. sent \(chunkIndex)")
    }
    
}

extension FileManager {
    func isDirectory(atPath path: String) -> Bool {
        var isDir: ObjCBool = false
        self.fileExists(atPath: path, isDirectory: &isDir)
        return isDir.boolValue
    }
}
