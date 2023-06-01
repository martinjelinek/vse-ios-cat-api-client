//
//  CatBreedsListView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 01.06.2023.
//

import SwiftUI

struct BreedListView: View {
    
    @StateObject var viewModel: BreedsListViewModel
    
    var body: some View {
        makeBreedListView(viewModel: viewModel)
    }
}

private extension BreedListView {
    
    func makeBreedListView(viewModel: BreedsListViewModel) -> some View {
        ScrollView {
            switch viewModel.state {
            case .initial, .loading:
                ProgressView()
            case .featched(let breeds):
                LazyVStack {
                    ForEach(breeds) { breed in
                        NavigationLink(destination: BreedDetailView(breed: breed)) {
                            makeBreedListItem(catBreed: breed)
                        }
                    }
                }
            case .failed:
                Text("Something went wrong")
            }
        }
    }
    
    func makeBreedListItem(catBreed: Breed) -> some View {
        ScrollView {
            Group {
                LazyVStack {
                    NavigationLink(destination: BreedDetailView(breed: catBreed)) {
                        BreedListItemView(breed: catBreed)
                    }
                }
                .padding(16)
            }
        }
    }
}
