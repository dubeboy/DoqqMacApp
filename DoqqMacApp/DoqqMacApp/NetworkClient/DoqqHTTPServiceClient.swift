//
//  DoqqHTTPServiceClient.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

import Foundation

/// App wide service
final class DoqqHTTPServiceClient {
    private let baseURL: URL? = URL(string: "http://localhost:11434/")
    private init() {}
    
    static let shared = DoqqHTTPServiceClient() // this can be a singleton because URL session is one but does not make much diff to me either way or you can make it a struct
    
    /// Model and URL agnostic, mainly serializes and desirilizes or requests and responses
    func makeRequest<T: Decodable>(_ endpoint: EndpointProtocol, for response: T.Type) async throws -> T {
        let request = createURLRequestObject(for: endpoint)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        print(String(data: data, encoding: .utf8))
        return try decoder.decode(response.self, from: data)
    }
}

// MARK: - Private Helper functions

extension DoqqHTTPServiceClient {
    private func createURLRequestObject(for endpoint: EndpointProtocol) -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(endpoint.path) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        // Serialize the request body if present
        if let body = endpoint.body {
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                fatalError("Failed to encode request body: \(error)")
            }
        }
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
}
