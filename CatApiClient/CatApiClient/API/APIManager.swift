//
//  APIManaging.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParams: [String: String] { get }
    
    func asURLRequest() throws -> URLRequest
}

extension Endpoint {
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var urlParams: [String: String] {
        [:]
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: Constants.baseAPIUrl)
        
        // TODO
        
        return request
    }
}

protocol APIManaging {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class APIManager: APIManaging {
    
    enum APIError: Error {
        case unaccaptableStatusCode
        case decodingFailed
    }
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        
        // TODO
        
        return URLSession(configuration: config)
    }()
    
    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
    
        
        let request = try endpoint.asURLRequest()
        
        let (data, response) = try await session.data(for: request)
        
        let httpResponse = response as? HTTPURLResponse
        
        guard let status = httpResponse?.statusCode, (200...299).contains(status) else {
            throw APIError.unaccaptableStatusCode
        }
        
        print(response)
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw APIError.decodingFailed
        }
    }
}
