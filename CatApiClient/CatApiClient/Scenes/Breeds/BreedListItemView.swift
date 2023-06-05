//
//  CatListView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import SwiftUI

struct BreedListItemView: View {
    let breed: Breed
    
    @StateObject var imageViewModel: BreedImageViewModel
    
    var body: some View {
        VStack {
            Text(breed.name)
                .font(.title)
                .foregroundColor(.black)
            HStack {
                switch imageViewModel.state {
                case .initial, .loading:
                    CattoProgressView()
                case .fetched:
                    if let image = imageViewModel.image {
                        makeImage(imageURL: URL(string: image.url)!)
                    }
                case .failed:
                    ErrorTextView(error:"No image for this catto")
                }
                Text(breed.temperament ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(5)
                    .truncationMode(.tail)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onFirstAppear {
            Task {
                await imageViewModel.load(imageId: breed.referenceImageId)
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
            CattoProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
    }
}
