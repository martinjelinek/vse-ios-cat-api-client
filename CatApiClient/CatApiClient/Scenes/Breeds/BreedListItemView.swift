//
//  CatListView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import SwiftUI

struct BreedListItemView: View {
    let breedImage: BreedImage
    
    var body: some View {
        HStack {
            makeImage(url: breedImage.url)
            VStack {
                Text(breedImage.id)
                    .font(.title)
                
                Text(breedImage.id)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
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
