//
//  ErrorTextView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 05.06.2023.
//

import SwiftUI

struct ErrorTextView: View {
    let error: String
    
    var body: some View {
        Text(error).font(.body).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .center)
    }
}
