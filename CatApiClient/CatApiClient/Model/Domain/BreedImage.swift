//
//  Cat.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import Foundation

struct BreedImage: Decodable {
    let id: String
    let width: Int
    let height: Int
    let url: URL
    let breeds: [Breed]?
}

struct Breed: Decodable {
    let weight: Weight
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let countryCodes: String?
    let countryCode: String?
    let lifeSpan: String?
    let wikipediaURL: URL?

    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case lifeSpan = "life_span"
        case wikipediaURL = "wikipedia_url"
    }
}

struct Weight: Decodable {
    let imperial: String
    let metric: String
}

struct Favourite: Decodable {}


// MARK: - Extension
extension BreedImage: Identifiable {}

// MARK: - Debug
#if DEBUG
extension BreedImage {
    static let mock: BreedImage = .init(
        id: "id_1",
        width: 1,
        height: 1,
        url: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.theguardian.com%2Flifeandstyle%2F2020%2Fsep%2F05%2Fwhat-cats-mean-by-miaow-japans-pet-guru-knows-just-what-your-feline-friend-wants&psig=AOvVaw0jht7rKDhTHL1ncCdbfVH-&ust=1685756819075000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCIjp5tS7o_8CFQAAAAAdAAAAABAE)")!,
        breeds: []
    )
    
    static let mockedBreeds: [BreedImage] = [.mock]
}
#endif
