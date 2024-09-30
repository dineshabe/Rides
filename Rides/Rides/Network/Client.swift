//
//  Client.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import Foundation

protocol NetworkClient {
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension NetworkClient {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            let err = ApiError.requestFailed(description: "Invalid response")
            throw err
        }
                
        guard httpResponse.statusCode == 200 else {
            let err = ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)", code: httpResponse.statusCode)
            throw err
        }
  
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch let error {
            let err = ApiError.jsonConversionFailure(description: error.localizedDescription)
            throw err
        }
    }
}

class BaseClient: NetworkClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

enum ApiUrl {
    case getVehicles(count: Int)
    
    var request: NSMutableURLRequest {
        switch self {
            case let .getVehicles(count):
                return NSMutableURLRequest(url: URL(string: baseUrl + "vehicle/random_vehicle?size=\(count)")!)
        }
    }
    
    var baseUrl: String {
        return "https://random-data-api.com/api/"
    }
}

enum ApiError: Error {
 case requestFailed(description: String)
 case invalidData
 case responseUnsuccessful(description: String, code: Int)
 case jsonConversionFailure(description: String)
 case jsonParsingFailure
 case failedSerialization
 case noInternet

    var customDescription: String {
        switch self {
           case let .requestFailed(description): return "Request Failed: \(description)"
           case .invalidData: return "Invalid Data)"
           case let .responseUnsuccessful(description, _): return "Unsuccessful: \(description)"
           case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
           case .jsonParsingFailure: return "JSON Parsing Failure"
           case .failedSerialization: return "Serialization failed."
           case .noInternet: return "No internet connection"
        }
    }
}

