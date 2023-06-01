//
//  CatDetailView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 30.05.2023.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: Breed
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            VStack {
                makeImage(url: breed.imageUrl)
                Text(breed.name)
                    .font(.title)
                
                Text(breed.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(16)
        }
        .navigationTitle(breed.name)
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
}
