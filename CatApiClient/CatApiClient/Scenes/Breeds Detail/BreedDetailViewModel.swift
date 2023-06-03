//
//  BreedDetailViewModel.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

@MainActor final class BreedDetailViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    var id: String?
    @Published var state: State = .initial
    @Published var breed: Breed?
    
    nonisolated init(id: String? = nil) {
        self.id = id
    }
    
    func load() async {
        state = .loading
        await fetch()
    }
    
    func fetch() async {
        state = .loading
        state = .fetched
        breed = Breed.mock
    }
}
