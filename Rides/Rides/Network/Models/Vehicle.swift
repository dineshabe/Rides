//
//  Vehicle.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

struct Vehicle: Codable, Identifiable {
    let id: Int
    let uid, vin, makeAndModel, color: String
    let transmission, driveType, fuelType, carType: String
    let carOptions, specs: [String]
    let doors, mileage, kilometrage: Int
    let licensePlate: String

    enum CodingKeys: String, CodingKey {
        case id, uid, vin
        case makeAndModel = "make_and_model"
        case color, transmission
        case driveType = "drive_type"
        case fuelType = "fuel_type"
        case carType = "car_type"
        case carOptions = "car_options"
        case specs, doors, mileage, kilometrage
        case licensePlate = "license_plate"
    }
    
    enum SortKeys: String, CaseIterable {
        case vin = "VIN"
        case mileage = "Mileage"
        case kilometrage = "Kilometrage"
        case licensePlate = "License Plate"
    }
    
    struct EmissionsSlab {
        let upperLimit: Double?
        let rate: Double
    }
    
    static let emissionSlabs = [
        EmissionsSlab(upperLimit: 5000, rate: 1),  // x1 for kilometrage up to 5,000
        EmissionsSlab(upperLimit: nil, rate: 1.5)  // x1.5 for kilometrage above 5,000
    ]
}

extension Vehicle {

    func getEmissions() -> Double {
        var remainingKilometrage: Double = Double(kilometrage)
        var total = 0.0

        for slab in Vehicle.emissionSlabs {
            if let limit = slab.upperLimit {
                let emission = min(remainingKilometrage, limit)
                total += emission * slab.rate
                remainingKilometrage -= emission
                if remainingKilometrage <= 0 {
                    break
                }
            } else {
                total += remainingKilometrage * slab.rate
                break
            }
        }
        return total
    }
}

extension Array where Element == Vehicle {
    func sort(key: Vehicle.SortKeys) -> [Vehicle] {
        switch(key) {
        case .kilometrage:
            return self.sorted { $0.kilometrage < $1.kilometrage }
        case .licensePlate:
            return self.sorted { $0.licensePlate < $1.licensePlate }
        case .mileage:
            return self.sorted { $0.mileage < $1.mileage }
        case .vin:
            return self.sorted { $0.vin < $1.vin }
        }
    }
}
