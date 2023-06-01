//
//  BreedViewModel.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 01.06.2023.
//

import Foundation

@MainActor final class BreedsListViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case featched(breeds: [Breed])
        case failed
    }
    
    @Published var state: State = .initial
    
    func fetch() async {
        try! await Task.sleep(for: .seconds (2))
        
        state = .featched(breeds: Breed.mockedBreeds)
    }
}
