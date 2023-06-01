//
//  ContentView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 30.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientView()
                BreedListView(
                    viewModel: BreedsListViewModel()
                )
            }
        }
    }
}
