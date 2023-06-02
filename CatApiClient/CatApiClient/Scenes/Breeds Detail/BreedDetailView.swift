//
//  CatDetailView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 30.05.2023.
//

import SwiftUI

struct BreedDetailView: View {
    @StateObject var viewModel: BreedDetailViewModel
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            ScrollView {
                VStack {
                    switch viewModel.state {
                    case .initial, .loading:
                        ProgressView()
                    case .fetched:
                        if let breedImage = viewModel.breed {
                            makeImage(url: breedImage.url)
                            makeInfo(breedImage: breedImage)
                        }
                    case .failed:
                        Text("Something went wrong")
                    }

                }
            }
            .padding(16)
        }
        .navigationTitle("")
        .onFirstAppear {
            Task {
                await viewModel.fetch()
            }
        }
    }
}

private extension BreedDetailView {
    func makeImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }
    
    func makeInfo(breedImage: BreedImage) -> some View {
        VStack {
            Text(breedImage.id)
                .font(.title)
            Text(breedImage.id)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
