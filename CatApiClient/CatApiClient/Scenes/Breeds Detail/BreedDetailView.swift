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
                        if let breed = viewModel.breed {
                            if let referenceImageId = breed.referenceImageId {
//                                makeImage(url: breed.getBreedImageURL(imageID: referenceImageId))
                            }
                            makeInfo(breed: breed)
                        }
                    case .failed:
                        Text("Something went wrong")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
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
    
    func makeInfo(breed: Breed) -> some View {
        VStack {
            Text(breed.id)
                .font(.title)
            Text(breed.id)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            if let adaptibility = breed.adaptability {
                makeProgressBarView(title: "Adaptibility", value: adaptibility)
            }
        }
    }
    
    func makeProgressBarView(title: String, value: Int) -> some View {
        VStack {
        Text(title)
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: CGFloat(value / 5) * geometry.size.width, height: 10)
                    .foregroundColor(.blue)
            }
        }
    }
}
}
