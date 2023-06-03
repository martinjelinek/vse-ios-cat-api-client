//
//  HTTPHeader.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

enum HTTPHeader {
    enum HeaderField: String {
        case contentType = "Content-Type"
    }
    
    enum ContentType: String {
        case json = "applications/json"
        case text = "text/html;charset=utf-8"
    }
}
