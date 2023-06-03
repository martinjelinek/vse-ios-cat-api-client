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
                await viewModel.load()
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
            case .fetched:
                makeBreedList()
            case .failed:
                Text("Something went wrong")
            }
        }
    }
    
    func makeBreedList() -> some View {
        LazyVStack {
            ForEach(viewModel.breeds) { breed in
                NavigationLink(destination: BreedDetailView(viewModel: BreedDetailViewModel(id: breed.id))) {
                    BreedListItemView(breed: breed, viewModel: BreedImageViewModel())
                }
            }
        }
        .padding(16)
        .navigationTitle("Breeds list").font(.title).foregroundColor(.black)
    }
}
