//
//  BreedDetailViewModel.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

struct Property {
    let title: String
    let value: Int?
}

@MainActor final class BreedDetailViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    var id: String?
    @Published var state: State = .initial
    @Published var breed: Breed?
    @Published var properties: [Property]?
    
    nonisolated init(id: String? = nil) {
        self.id = id
    }
    
    func load() async {
        state = .loading
        await fetch()
    }
    
    private func fetch() async {
        
        do {
            let endpoint = BreedEndpoint.getBreedById(breedId: id)
            let response: Breed = try await apiManager.request(endpoint: endpoint)
            debugPrint(response)
            breed = response
            fillProperties(breed: breed!)
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
    
    private func fillProperties(breed: Breed) {
        properties = [
            Property(title: "Adaptability", value: breed.adaptability),
            Property(title: "Affection Level", value: breed.affectionLevel),
            Property(title: "Child Friendly", value: breed.childFriendly),
            Property(title: "Dog Friendly", value: breed.dogFriendly),
            Property(title: "Energy Level", value: breed.energyLevel),
            Property(title: "Grooming", value: breed.grooming),
            Property(title: "Health Issues", value: breed.healthIssues),
            Property(title: "Intelligence", value: breed.intelligence),
            Property(title: "Shedding Level", value: breed.sheddingLevel),
            Property(title: "Social Needs", value: breed.socialNeeds),
            Property(title: "Stranger Friendly", value: breed.strangerFriendly),
            Property(title: "Vocalisation", value: breed.vocalisation),
            Property(title: "Experimental", value: breed.experimental),
            Property(title: "Hairless", value: breed.hairless),
            Property(title: "Natural", value: breed.natural),
            Property(title: "Rare", value: breed.rare),
            Property(title: "Rex", value: breed.rex),
            Property(title: "Suppressed Tail", value: breed.suppressedTail),
            Property(title: "Short Legs", value: breed.shortLegs),
            Property(title: "Hypoallergenic", value: breed.hypoallergenic)
        ]
        
        properties!.sort { $0.value ?? 0 > $1.value ?? 0 }
    }
}
