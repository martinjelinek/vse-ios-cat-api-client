//
//  ProgressBarView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 05.06.2023.
//

import SwiftUI

struct ValueDisplayingProgressBarView: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack {
            Text(title)
            makeProgressBar(value: value)
        }
    }
}

private func makeProgressBar(value: Int) -> some View {
    var valueDouble = Double(value)
    if (valueDouble == 0.0) {
        valueDouble += 0.1
    }

    return ProgressView(value: valueDouble, total: 5)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
}
