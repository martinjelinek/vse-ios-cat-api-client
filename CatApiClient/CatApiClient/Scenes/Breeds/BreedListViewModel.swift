//
//  BreedViewModel.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 01.06.2023.
//

import Foundation

@MainActor final class BreedListViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    @Published var breeds: [Breed] = []
    @Published var breedImages: [(String?, URL?)] = []
    @Published var state: State = .initial
    
    func load() async {
        state = .loading
        await fetch()
    }
    
    private func fetch() async {
        
        do {
            let endpoint = BreedEndpoint.getBreeds
            let response: [Breed] = try await apiManager.request(endpoint: endpoint)
            debugPrint(response)
            breeds = response
            state = .fetched
        } catch {
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled: ", .info)
                state = .fetched
                
                return
            }
            debugPrint(error)
            state = .failed
        }
    }
}
