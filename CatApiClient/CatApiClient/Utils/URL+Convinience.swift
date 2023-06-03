//
//  URL+Convinience.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 03.06.2023.
//

import Foundation

extension URL {
    func valueOf(queryParameter: String) -> String? {
        guard let url = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        return url.queryItems?
            .first { $0.name == queryParameter }?
            .value
    }
}
