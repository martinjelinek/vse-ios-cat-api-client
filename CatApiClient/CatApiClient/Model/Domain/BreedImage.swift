//
//  BreedImage.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

struct BreedImage: Decodable {
    
    let id: String
    let width: Int
    let height: Int
    let url: String
    let breeds: [Breed]
}
enum CodingKeys: String, CodingKey {
    case weight, id, name, temperament, origin, countryCodes, countryCode, lifeSpan, wikipediaUrl
}
