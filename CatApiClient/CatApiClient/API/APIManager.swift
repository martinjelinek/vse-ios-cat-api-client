//
//  APIManaging.swift
//  CatApiClient
//
//  Created by Martin Jelínek on 02.06.2023.
//

import Foundation

protocol APIManaging {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class APIManager: APIManaging {
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        
        return URLSession(configuration: config)
    }()
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T where T : Decodable {
        
        let request = try endpoint.asURLRequest()
        
        let (data, response) = try await session.data(for: request)
        
        let httpResponse = response as? HTTPURLResponse
        
        guard let status = httpResponse?.statusCode, (200...299).contains(status) else {
            throw APIError.unaccaptableStatusCode
        }
        
        debugPrint("Finished request: \(response)")
        
        let decoder = JSONDecoder()
        do {
            debugPrint("Data: ", data)
            debugPrint(T.self)
            let result = try decoder.decode(T.self, from: data)
            debugPrint("Result: ", result)
            return result
        } catch {
            debugPrint("Decoding error: \(error)")
            throw APIError.decodingFailed
        }
    }
}
