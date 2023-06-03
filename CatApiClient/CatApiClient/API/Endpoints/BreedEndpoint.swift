//
//  BreedImageEndpoint.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

enum BreedEndpoint: Endpoint {
case getBreeds
case getBreedById(breedId: String?)
    
    var path: String {
        switch self {
        case .getBreeds, .getBreedById:
            return "breeds"
        }
    }
    
    var urlParams: [String : String] {
        switch self {
        case .getBreedById(let breedId):
            if let id = breedId {
                return ["breedId": id]
            } else {
                return [:]
            }
        case .getBreeds:
            return [:]
        }
    }
}
