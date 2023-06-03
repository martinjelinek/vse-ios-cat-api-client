//
//  BreedImagesViewModel.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 03.06.2023.
//

import Foundation

@MainActor final class BreedImageViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    @Published var image: BreedImage? = nil
    @Published var state: State = .initial
    
    func load(imageId: String?) async {
        state = .loading
        await fetch(imageId: imageId)
    }
    
    private func fetch(imageId: String?) async {
        do {
            if let imgId = imageId {
                let endpoint = BreedImageEndpoint.getImageById(id: imgId)
                let response: BreedImage = try await apiManager.request(endpoint: endpoint)
                
                image = response
                state = .fetched
            } else {
                state = .failed
            }
        } catch {
            state = .failed
            debugPrint(error)
        }
    }
}
