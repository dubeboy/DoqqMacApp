//
//  OllamaModel.swift
//  Doque
//
//  Created by Divine Dube on 28/01/2025.
//

import Foundation

struct OllamaModelResponse: Codable {
    let models: [Model]
}

struct Model: Codable {
    let name: String
    let model: String
    let modifiedAt: String
    let size: Int64
    let digest: String
    let details: ModelDetails

    enum CodingKeys: String, CodingKey {
        case name
        case model
        case modifiedAt = "modified_at"
        case size
        case digest
        case details
    }
}

struct ModelDetails: Codable {
    let parentModel: String
    let format: String
    let family: String
//    let families: [String]?
    let parameterSize: String
    let quantizationLevel: String

    enum CodingKeys: String, CodingKey {
        case parentModel = "parent_model"
        case format
        case family
//        case families
        case parameterSize = "parameter_size"
        case quantizationLevel = "quantization_level"
    }
}
