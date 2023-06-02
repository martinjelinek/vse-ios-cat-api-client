//
//  CatBreedsListView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 01.06.2023.
//

import SwiftUI

struct BreedListView: View {
    
    @StateObject var viewModel: BreedListViewModel
    
    var body: some View {
        makeBreedListView(viewModel: viewModel).onFirstAppear {
            Task {
                await viewModel.fetch()
            }
        }
    }
}

private extension BreedListView {
    
    func makeBreedListView(viewModel: BreedListViewModel) -> some View {
        ScrollView {
            switch viewModel.state {
            case .initial, .loading:
                ProgressView()
            case .fetched(let breeds):
                LazyVStack {
                    ForEach(breeds) { breed in
                        NavigationLink(destination: BreedDetailView(viewModel: BreedDetailViewModel())) {
                            makeBreedListItem(catBreed: breed)
                        }
                    }
                }
            case .failed:
                Text("Something went wrong")
            }
        }
    }
    
    func makeBreedListItem(catBreed: BreedImage) -> some View {
        ScrollView {
            Group {
                LazyVStack {
                    NavigationLink(destination: BreedDetailView(viewModel: BreedDetailViewModel())) {
                        BreedListItemView(breedImage: catBreed)
                    }
                }
                .padding(16)
            }
        }
    }
}
