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
        case .getBreeds:
            return "breeds"
        case .getBreedById(breedId: let breedId):
            return "breeds/\(String(describing: breedId!))"
        }
    }
    
    var urlParams: [String : String] {
        switch self {
        case .getBreeds, .getBreedById:
            return [:]
        }
    }
}
