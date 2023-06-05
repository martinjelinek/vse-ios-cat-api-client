//
//  CatDetailView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 30.05.2023.
//

import SwiftUI

struct BreedDetailView: View {
    @StateObject var viewModel: BreedDetailViewModel
    @StateObject var imageViewModel: BreedImageViewModel
    
    @State var isExpanded = false
    @State var isWikiPresent = false
    @State var isWikiToggled = false
    
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            ScrollView {
                VStack {
                    switch viewModel.state {
                    case .initial, .loading:
                        CattoProgressView()
                    case .fetched:
                        if let breed = viewModel.breed {
                            switch imageViewModel.state {
                            case .initial, .loading:
                                CattoProgressView()
                            case .fetched:
                                if let image = imageViewModel.image {
                                    makeImage(url: URL(string: image.url))
                                }
                            case .failed:
                                ErrorTextView(error: "No image for this catto")
                            }
                            makeInfo(breed: breed)
                            Button(action: {
                                isExpanded.toggle()
                            }) {
                                if isExpanded {
                                    HStack {
                                        Text("Show less").foregroundColor(.blue)
                                        Image(systemName: "chevron.up")
                                    }
                                } else {
                                    HStack {
                                        Text("Show more").foregroundColor(.blue)
                                        Image(systemName: "chevron.down")
                                    }
                                }
                            }
                            .padding(16)
                            if (isExpanded) {
                                if let properties = viewModel.properties {
                                    makeValuesSegment(properties: properties)
                                }
                            }
                        }
                    case .failed:
                        ErrorTextView(error: "Something went wrong")
                    }
                    Spacer().frame(height: 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(16)
            }
            .navigationBarTitle(viewModel.breed?.name ?? "")
        }
        .toolbar {
            if (isWikiPresent) {
                ToolbarItem {
                    Button(action: {
                        isWikiToggled = !isWikiToggled
                    }) {
                        Text("Wiki")
                    }
                }
            }
        }
        .sheet(isPresented: $isWikiToggled) {
            if let urlString = viewModel.breed?.wikipediaUrl {
                WebView(url: URL(string: urlString)!)
            }
        }
        .onFirstAppear {
            Task {
                await viewModel.load()
                await imageViewModel.load(imageId: viewModel.breed?.referenceImageId)
                if (viewModel.breed?.wikipediaUrl) != nil {
                    Task { isWikiPresent.toggle() }
                }
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
        .padding(16)
    }
    
    func makeInfo(breed: Breed) -> some View {
        LazyVStack {
            if let desc = breed.description {
                Text(desc).font(.body)
            }
            Spacer().frame(height: 20)
            if let origin = breed.origin {
                makeInfoRow(title: "Origin: ", value: origin)
            }
            Spacer()
            if let lifeSpan = breed.lifeSpan {
                makeInfoRow(title: "Life span: ", value: "\(lifeSpan) years")
            }
            Spacer()
            if let temperament = breed.temperament {
                makeInfoRow(title: "Temperament: ", value: temperament)
            }
            Spacer()
            makeInfoRow(title: "Weight: ", value: "\(breed.weight.metric) kg")
        }
        .padding(16)
    }
    
    func makeInfoRow(title: String, value: String) -> some View {
        VStack {
            Text(title).font(.subheadline)
            Text(value).font(.caption)
        }
    }
    
    func makeValuesSegment(properties: [Property]) -> some View {
        LazyVStack {
            ForEach(properties, id: \.title) { property in
                if let value = property.value {
                    ValueDisplayingProgressBarView(title: property.title, value: value)
                }
            }
        }
    }
}
