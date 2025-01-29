//
//  DoqqViewModel.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import SwiftUI
import Foundation
import SwiftData

@Observable
class ConversationViewModel {
    
    enum State {
        case loading, ollamaNotRunning, initLoaded, initLoadFail, askingLLM, errorAskingLLM, successAskingLLM
    }
    
    @ObservationIgnored
    @LateInitialized
    private var context: ModelContext
    private let conversationManager = ConversationManager()
    private let primeMessage = primeString
    private let endSignal = "END_CHUNK_SEND"
    private let conversationService = ConversationService() // Does not have to be a singleton but can be also
    
    var state: State = .loading
    var selectedSession: Int = 0 {
        didSet {
            loadSelectedSessionConversations(session: selectedSession)
        }
    }
    var numErrorWhenSendingChunks: Int = 0
    var sessions: [ConversationSessionDTO] {
        conversationManager.sessions
    }
    /// Because `selectedSession` changes per selection ,
    /// we need to disable until we are done interacating with LLM agent to avoid race conditions
    var disableInteraction: Bool {
        state == .askingLLM
    }
    /// Current session that we can see on the view
    var selectedSessionMessages: [MessageStateModel] = []
    var installedModels: [StateModel] = []
    var selectedModel: String {
        guard !installedModels.isEmpty, !sessions.isEmpty else {
            return "New Session"
        }
        return "\(sessions[selectedSession].modelName)"
    }
    
    /// sets the model
    /// Call this on viewdidApear
    @MainActor
    func loadSessions(with context: ModelContext) async {
        state = .loading
        selectedSessionMessages = [(.init(role: "user", content: "Initializing", isQuery: false))]
        guard let model = await getInstalledModels() else {
            selectedSessionMessages.append(.init(role: "user", content: "Ollama not Installed. Please installed Ollama", isQuery: false))
            selectedSessionMessages.append(.init(role: "user", content: "Please download Ollama from `https://ollama.com`", isQuery: false))
            selectedSessionMessages.append(.init(role: "user", content: "Its quite straight forward. After this is done Please click `Try again`", isQuery: false))
            state = .ollamaNotRunning
            return
        }
        
        if model.models.isEmpty {
           
            selectedSessionMessages.append(.init(role: "user", content: "Ollama Installed but No LLM Found", isQuery: false))
            selectedSessionMessages.append(.init(role: "user", content: "You can install one by running `ollama run codellama:13b`", isQuery: false))
            selectedSessionMessages.append(.init(role: "user", content: "Feel free to download one here: https://ollama.com/search that is suites your needs", isQuery: false))
            selectedSessionMessages.append(.init(role: "user", content: "Once Done Please click `Try again`", isQuery: false))
            state = .ollamaNotRunning
            return
        }
        
        installedModels = model.models
        
        state = .askingLLM
        self.context = context
        do {
            try conversationManager.loadSessions(with: context)
            guard !sessions.isEmpty else {
                state = .initLoaded
                return
            }
            selectedSession = sessions.count - 1
            selectedSessionMessages = sessions[selectedSession].chatHistory.compactMap { message in
                message.isEnd ? nil : MessageStateModel(message: message)
            }
            state = .initLoaded
        } catch {
            print("Error")
            print(error)
            state = .initLoadFail
        }
    }
    
    func askDoqq(message: String, name: String = "New Session") async {
        do {
            state = .askingLLM
            let message = MessageStateModel(role: "user", content: message, isQuery: true)
            selectedSessionMessages.append(message)
            let response = try await conversationManager.askDoqq(session: selectedSession, modelName: selectedModel, name: name, message: message.toPayload())
            selectedSessionMessages.append(.init(role: response.message.role, content: response.message.content, isQuery: false))
            //            try await conversationManager.saveBatch(id: selectedSession, name: name, messages: [message.toPayload(), response.message])
            state = .successAskingLLM
        } catch {
            state = .errorAskingLLM
        }
    }
    
    private func loadSelectedSessionConversations(session id: Int) {
        selectedSessionMessages = []
        do {
            selectedSessionMessages = try conversationManager.findSession(for: id)?.chatHistory.compactMap { message in
                message.isEnd ? nil : MessageStateModel(message: message)
            } ?? []
        } catch {
            print("### Error")
            print(error)
        }
    }
    
    func processFiles(model: StateModel, cocoapodsRoot: String) async {
        state = .askingLLM
      
        let selectedSessionConvesation = try? conversationManager.findSession(for: selectedSession)
        if let selectedSessionConvesation, !selectedSessionConvesation.chatHistory.isEmpty {
            selectedSession = sessions.count
        }
        let sessionName = cocoapodsRoot.components(separatedBy: "/").last ?? "New session \(selectedSession)"
        print("\n\nPrime the Llama3 agent for Project: \(sessionName)")
        selectedSessionMessages = [.init(role: "user", content: "Prime the Llama3 agent", isQuery: true)]
        var chunkIndex = 0
        do {
            // Send prime instructions to Llama3
            
            let _ = try await conversationManager.askDoqq(session: selectedSession, modelName: model.name, name: sessionName, message: Message(role: "user", content: primeMessage, isQuery: true, isEnd: true))
            selectedSessionMessages.append(.init(role: "user", content: "Ok. Success Prime LLama agent", isQuery: false))
            
            let fileManager = FileManager.default
            let enumerator = fileManager.enumerator(atPath: cocoapodsRoot)
            selectedSessionMessages.append(.init(role: "user", content: "Priming for dir \(cocoapodsRoot)", isQuery: false))
            
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
                        content: "\(payload)",
                        isQuery: true,
                        isEnd: true
                    )
                    
                    let response = try await conversationManager.askDoqq(session: selectedSession, modelName: model.name, name: sessionName, message: message)
                    print("### PRIME")
                    dump(response)
                } catch {
                    numErrorWhenSendingChunks += 1
                    print("Error reading or sending file \(fullPath): \(error)")
                }
            }
            
            if numErrorWhenSendingChunks == 0 {
                selectedSessionMessages.append(.init(role: "user", content: "Primed \(chunkIndex) files", isQuery: false))
                print("### Success OPRime")
                let response = try await conversationManager.askDoqq(
                    session: selectedSession, modelName: model.name, name: sessionName,
                    message: .init(role: "user",content: endSignal, isQuery: true,isEnd: true)
                )
                selectedSessionMessages.append(.init(role: "user", content: endSignal, isQuery: true))
                selectedSessionMessages.append(.init(role: "user", content: response.message.content, isQuery: false))
                //                try await conversationManager.saveBatch(id: selectedSession, name: sessionName, messages: sessions[selectedSession].chatHistory)
                state = .initLoaded
            } else {
                selectedSessionMessages.append(.init(role: "user", content: "Some code failed to be primed", isQuery: false))
                print("### Fail OPRime")
                state = .initLoadFail
            }
        } catch {
            selectedSessionMessages.append(.init(role: "user", content: "Something went wrong is Ollama running?", isQuery: false))
            state = .initLoadFail
            
        }
        print("\n\nFinished processing files. sent \(chunkIndex)")
    }
    
    /// Returns `true` if can get models this means that Ollama is Running else false
    private func getInstalledModels() async -> OllamaModelStateModel? {
        let models = try? await conversationService.ollamaListLocalModels()
        guard let models else {
            return nil
        }
        return OllamaModelStateModel(model: models)
    }
    
}

extension FileManager {
    func isDirectory(atPath path: String) -> Bool {
        var isDir: ObjCBool = false
        self.fileExists(atPath: path, isDirectory: &isDir)
        return isDir.boolValue
    }
}

@propertyWrapper
struct LateInitialized<Value> {
    private var storage: Value?
    
    var wrappedValue: Value {
        get {
            guard let storage = storage else {
                fatalError("Property accessed before being initialized.") // should probably not crash the app report this instead
            }
            return storage
        }
        set {
            storage = newValue
        }
    }
    
    init() {
        self.storage = nil
    }
}

let primeString =  """
    From now on, you will act as my **Smart Code Documentation Search Agent**. Your primary role is to assist me in searching and identifying whether
    specific or similar code exists in my code library based on natural language queries. 

    Here are the Instructions on how to do achieve this, written in Markdown format for you.

    #### How It Works:
    1. **Input Format**:  
       I will provide my library code to you in JSON format. Each entry will contain the following keys:  
       - `filename`: The name of the file.  
       - `relativePath`: The relative path to the file.  
       - `content`: The actual code content.  

    2. **Query Handling**:  
       - I will ask you questions in natural language, such as:  
         *"Code that can change the UINavigationBar to Green."*  
       - You will search through the provided library code and respond with any relevant matches.

    3. **Response Format**:  
       - If relevant code is found, reference the appropriate chunk index in **Github Markdown format** (e.g., `[Chunk 1]`).  
       - If no relevant code is found, simply state:  
         *"No matching code found for the query."*  

    4. **Agent Initialization Signal**:  
       - You must **not answer any code search queries** until I explicitly send the signal:  
         `END_CHUNK_SEND`.  
       - Once you receive this signal, you may begin answering queries based on the provided library code.

    ### Key Rules:
    - Wait for the `END_CHUNK_SEND` signal before answering any queries and only after this signal you answer question.  
    - Always reference the chunk index in Markdown format if relevant code is found.  
    - If no matching code exists, clearly state that nothing matches the query.
"""
