//
//  OllamaModelStateModel.swift
//  Doque
//
//  Created by Divine Dube on 28/01/2025.
//

import Foundation

struct OllamaModelStateModel: Identifiable {
    let id: UUID = UUID()
    let models: [StateModel]
    
    init(model: OllamaModelResponse) {
        self.models = model.models.map { model in
            StateModel(model: model)
        }
    }
}

struct StateModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    
    init(model: Model) {
        self.name = model.name
    }
}
