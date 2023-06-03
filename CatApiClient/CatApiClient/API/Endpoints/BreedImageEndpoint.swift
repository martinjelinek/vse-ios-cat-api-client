//
//  BreedImageEndpoint.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 03.06.2023.
//

import Foundation

enum BreedImageEndpoint: Endpoint {
    
case getImageById(id: String)
    
    var path: String {
        switch self {
        case .getImageById(let id):
            return "images/" + id
        }
    }
    
    var urlParams: [String : String] {
        switch self {
        case .getImageById:
            return [:]
        }
    }
}
