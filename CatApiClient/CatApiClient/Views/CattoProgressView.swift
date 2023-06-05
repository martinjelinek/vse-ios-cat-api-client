//
//  CattoProgressView.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 05.06.2023.
//

import SwiftUI

struct CattoProgressView: View {
    var body: some View {
        ProgressView()
            .frame(width: 30, height: 30, alignment: .center)
            .padding(20)
            
    }
}

struct CattoProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CattoProgressView()
    }
}
