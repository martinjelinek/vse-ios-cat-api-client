//
//  Cat.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import Foundation

struct Breed: Decodable {
    enum CodingKeys: String, CodingKey {
        case weight, id, name
        case cfaUrl = "cfa_url"
        case vetstreetUrl = "vetstreet_url"
        case vcahospitalsUrl = "vcahospitals_url"
        case temperament, origin, countryCodes, countryCode, description, lifeSpan, indoor, lap, altNames, adaptability, affectionLevel, childFriendly, dogFriendly, energyLevel, grooming, healthIssues, intelligence, sheddingLevel, socialNeeds, strangerFriendly, vocalisation, experimental, hairless, natural, rare, rex, suppressedTail, shortLegs, wikipediaUrl, hypoallergenic
        case referenceImageId = "reference_image_id"
    }
    
    struct Weight: Decodable {
        let imperial: String
        let metric: String
    }
    
    let weight: Weight
    let id: String
    let name: String
    let cfaUrl: String?
    let vetstreetUrl: String?
    let vcahospitalsUrl: String?
    let temperament: String?
    let origin: String?
    let countryCodes: String?
    let countryCode: String?
    let description: String?
    let lifeSpan: String?
    let indoor: Int?
    let lap: Int?
    let altNames: String?
    let adaptability: Int?
    let affectionLevel: Int?
    let childFriendly: Int?
    let dogFriendly: Int?
    let energyLevel: Int?
    let grooming: Int?
    let healthIssues: Int?
    let intelligence: Int?
    let sheddingLevel: Int?
    let socialNeeds: Int?
    let strangerFriendly: Int?
    let vocalisation: Int?
    let experimental: Int?
    let hairless: Int?
    let natural: Int?
    let rare: Int?
    let rex: Int?
    let suppressedTail: Int?
    let shortLegs: Int?
    let wikipediaUrl: String?
    let hypoallergenic: Int?
    let referenceImageId: String?
}

struct Favourite: Decodable {}


// MARK: - Extension
extension Breed: Identifiable {}

extension Breed {
    
}

// MARK: - Debug
#if DEBUG
extension Breed {
    static let mock: Breed = .init(
        weight: Breed.Weight(imperial: "7  -  10", metric: "3 - 5"),
        id: "abys",
        name: "Abyssinian",
        cfaUrl: "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
        vetstreetUrl: "http://www.vetstreet.com/cats/abyssinian",
        vcahospitalsUrl: "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
        temperament: "Active, Energetic, Independent, Intelligent, Gentle",
        origin: "Egypt",
        countryCodes: "EG",
        countryCode: "EG",
        description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        lifeSpan: "14 - 15",
        indoor: 0,
        lap: 1,
        altNames: "",
        adaptability: 5,
        affectionLevel: 5,
        childFriendly: 3,
        dogFriendly: 4,
        energyLevel: 5,
        grooming: 1,
        healthIssues: 2,
        intelligence: 5,
        sheddingLevel: 2,
        socialNeeds: 5,
        strangerFriendly: 5,
        vocalisation: 1,
        experimental: 0,
        hairless: 0,
        natural: 1,
        rare: 0,
        rex: 0,
        suppressedTail: 0,
        shortLegs: 0,
        wikipediaUrl: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
        hypoallergenic: 0,
        referenceImageId: "0XYvRd7oD"
    )
    
    
    
    //    static let mockedBreeds: [BreedImage] = [.mock]
}
#endif
