//
//  APIError.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

enum APIError: Error {
    case unaccaptableStatusCode
    case decodingFailed
    case invalidURLComponents
}
