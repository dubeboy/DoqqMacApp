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
        case loading, initLoaded, initLoadFail, askingLLM(Int), errorAskingLLM, successAskingLLM(Int)
    }
    
    @ObservationIgnored
    @LateInitialized
    private var context: ModelContext
    private let conversationManager = ConversationManager()
    private let primeMessage = primeString
    private let endSignal = "_END_CHUNK_SEND_"

    var state: State = .loading
    var selectedSession: Int = 0 {
        didSet {
            loadSelectedSessionConversations(session: selectedSession)
        }
    }
    var numErrorWhenSendingChunks: Int = 0
    var sessions: [ConversationSessionModel] {
        conversationManager.sessions
    }
    
    /// Current session that we can see on the view
    var selectedSessionMessages: [MessageStateModel] = []
    
    /// sets the model
    /// Call this on viewdidApear
    func loadSessions(with context: ModelContext) {
        self.context = context
        do {
            try conversationManager.loadSessions(with: context)
            guard !sessions.isEmpty else {
                state = .initLoaded
                return
            }
            selectedSessionMessages = sessions[selectedSession].chatHistory.map(MessageStateModel.init(message:))
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
            let response = try await conversationManager.askDoqq(session: selectedSession, name: name, message: message.toPayload())
            selectedSessionMessages.append(.init(role: response.message.role, content: response.message.content, isQuery: false))
            state = .successAskingLLM
        } catch {
            state = .errorAskingLLM
        }
    }
    
    private func loadSelectedSessionConversations(session id: Int) {
        selectedSessionMessages = []
        do {
            selectedSessionMessages = try conversationManager.findSession(for: id)?.chatHistory.map(MessageStateModel.init(message:)) ?? []
        } catch {
            print("### Error")
            print(error)
        }
    }
    
    func processFiles(cocoapodsRoot: String) async {
        let selectedSessionConvesation = try? conversationManager.findSession(for: selectedSession)
        if let selectedSessionConvesation, !selectedSessionConvesation.chatHistory.isEmpty {
            selectedSession += 1
        }
        let sessionName = cocoapodsRoot.components(separatedBy: "/").last ?? "New session \(selectedSession)"
        print("\n\nPrime the Llama3 agent for Project: \(sessionName)")
        selectedSessionMessages = [.init(role: "user", content: "Prime the Llama3 agent", isQuery: true)]
        var chunkIndex = 0
        state = .askingLLM
        do {
            // Send prime instructions to Llama3
            
            let _ = try await conversationManager.askDoqq(session: selectedSession, name: sessionName, message: Message(role: "user", content: primeMessage, isQuery: true))
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
                        isQuery: true
                    )
                    
                    let response = try await conversationManager.askDoqq(session: selectedSession, name: sessionName, message: message)
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
                let response = try await conversationManager.askDoqq(session: selectedSession, name: sessionName, message: .init(role: "user", content: endSignal, isQuery: true, isEnd: true))
                selectedSessionMessages.append(.init(role: "user", content: response.message.content, isQuery: false))
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
    ### Smart Code Documentation Search Agent Instructions

    From now on, you will act as my **Smart Code Documentation Search Agent**. Your primary role is to assist me in searching and identifying whether specific or similar code exists in my code library based on natural language queries. 

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
       - If relevant code is found, reference the appropriate chunk index in **Markdown format** (e.g., `[Chunk 1]`).  
       - If no relevant code is found, simply state:  
         *"No matching code found for the query."*  

    4. **Initialization Signal**:  
       - You must **not answer any code search queries** until I explicitly send the signal:  
         `END_CHUNK_SEND`.  
       - Once you receive this signal, you may begin answering queries based on the provided library code.

    ---

    ### Example Interaction

    #### Input (Library Code in JSON Format):
    ```json
    [
      {
        "filename": "ViewController.swift",
        "relativePath": "iOSApp/Views",
        "content": "class ViewController: UIViewController {\n  override func viewDidLoad() {\n    super.viewDidLoad()\n    navigationController?.navigationBar.barTintColor = .green\n  }\n}"
      }
    ]

    #### Signal:
    `END_CHUNK_SEND`

    #### Query:
    "Code that can change the UINavigationBar to Green."

    #### Response:
    "Relevant code found in `[Chunk 1]`."
        ```swift
            class ViewController: UIViewController {
                override func viewDidLoad() {
                    super.viewDidLoad()
                    navigationController?.navigationBar.barTintColor = .green
                }
            }
        ```
    ---

    ### Key Rules:
    - Wait for the `END_CHUNK_SEND` signal before answering any queries.  
    - Always reference the chunk index in Markdown format if relevant code is found.  
    - If no matching code exists, clearly state that nothing matches the query.
"""
