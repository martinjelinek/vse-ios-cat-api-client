//
//  Cat.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 31.05.2023.
//

import Foundation

struct Breed {
    let id: Int
    let name: String
    let description: String
    
    var imageUrl: URL = URL(string: "https://media.npr.org/assets/img/2021/08/11/gettyimages-1279899488_wide-f3860ceb0ef19643c335cb34df3fa1de166e2761-s1100-c50.jpg")!
}

// MARK: - Extension
extension Breed: Identifiable {}

// MARK: - Debug
#if DEBUG
extension Breed {
    static let mockedBreeds: [Breed] = [
        .init(
            id: 1,
            name: "cat 1",
            description: "This is a nice cat purr purrrrr"
        ),
        .init(
            id: 2,
            name: "cat 2",
            description: "This is a nice cat purr purrrrr"
        ),
        .init(
            id: 3,
            name: "cat 3",
            description: "This is a nice cat purr purrrrr"
        )
    ]
}
#endif
