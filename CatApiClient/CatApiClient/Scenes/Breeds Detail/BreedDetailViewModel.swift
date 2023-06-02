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
    
    var id: Int?
    @Published var state: State = .initial
    @Published var breed: BreedImage?
    
    nonisolated init(id: Int? = nil) {
        self.id = id
    }
    
    func fetch() async {
        state = .loading
        try! await Task.sleep(for: .seconds(2))
        state = .fetched
        breed = BreedImage.mock
    }
}
