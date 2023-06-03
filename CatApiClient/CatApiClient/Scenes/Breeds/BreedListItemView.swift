//
//  CatListView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import SwiftUI

struct BreedListItemView: View {
    let breed: Breed
    
    var body: some View {
        VStack {
            Text(breed.name)
                .font(.title)
                .foregroundColor(.black)
            // TODO fetch image
            if let referenceImageId = breed.referenceImageId {
                makeImage(url: breed.getBreedImageURL(imageID: referenceImageId))
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
    }
}

private extension BreedListItemView {
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
}
