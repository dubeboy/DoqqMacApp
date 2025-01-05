//
//  OllamaResponse.swift
//  DoqqMacApp
//
//  Created by Divine Dube on 05/01/2025.
//

struct OllamaResponse: Codable {
    let model: String
    let createdAt: String
    let message: Message
    let doneReason: String
    let done: Bool
    let totalDuration: Int
    let loadDuration: Int
    let promptEvalCount: Int
    let promptEvalDuration: Int
    let evalCount: Int
    let evalDuration: Int

    enum CodingKeys: String, CodingKey {
        case model
        case createdAt = "created_at"
        case message
        case doneReason = "done_reason"
        case done
        case totalDuration = "total_duration"
        case loadDuration = "load_duration"
        case promptEvalCount = "prompt_eval_count"
        case promptEvalDuration = "prompt_eval_duration"
        case evalCount = "eval_count"
        case evalDuration = "eval_duration"
    }
}

