//
//  DoqqHTTPServiceClient.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

final class DoqqHTTPServiceClient {
    private let baseURL: String = ""
    
    private let shared = DoqqHTTPServiceClient()
    
    private init() {}
    
    func sendToLlama3(message: OllamaPayload, role: String = "user") async -> String? { // No need for generics for no
    }
}
