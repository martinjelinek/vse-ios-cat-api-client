//
//  BackgroudGradientView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(
            gradient: .init(colors: [Color.gray, Color.black]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}
