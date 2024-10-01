//
//  RideClient.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import Foundation

protocol RideClientProtocol {
    func fetchVehicles(count: Int) async throws -> [Vehicle]
}

final class RidesClient: RideClientProtocol, NetworkClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchVehicles(count: Int) async throws -> [Vehicle] {
        let request = ApiUrl.getVehicles(count: count).request
        request.httpMethod = "GET"
        do {
            let result = try await self.fetch(type: [Vehicle].self, with: request as URLRequest)
            return result
        } catch let err {
            throw err
        }
    }
}
