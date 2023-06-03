//
//  CatListView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import SwiftUI

struct BreedListItemView: View {
    let breed: Breed
    
    @StateObject var viewModel: BreedImageViewModel
    
    var body: some View {
        VStack {
            Text(breed.name)
                .font(.title)
                .foregroundColor(.black)
            // TODO fetch image
            switch viewModel.state {
            case .initial, .loading:
                ProgressView()
            case .fetched:
                if let image = viewModel.image {
                    makeImage(imageURL: URL(string: image.url)!)
                }
            case .failed:
                Text("No image for this catto")
            }
            Text(breed.description ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(5) // Limits the text to a single line
                .truncationMode(.tail)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onFirstAppear {
            Task {
                await viewModel.load(imageId: breed.referenceImageId)
            }
        }
    }
}

private extension BreedListItemView {
    func makeImage(imageURL: URL) -> some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }
}
