//
//  BreedViewModel.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 01.06.2023.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    
    struct Info: Decodable {
        let weight: String
        let count: Int
        let next: String?
        let previous: String?
    }
    
    let info: Info
    let results: T
}

@MainActor final class BreedListViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched(breedImages: [BreedImage])
        case failed
    }
    
    @Published var state: State = .initial
    
    func fetch() async {
        state = .loading
        
        let url = Constants.baseAPIUrl
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Print the raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let breedImages = try decoder.decode([BreedImage].self, from: data)
            
            
            state = .fetched(breedImages: breedImages)
            
        } catch {
            print("Error: \(error)")
            state = .failed
        }
    }
}
