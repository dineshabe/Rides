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
        case carType = "Car Type"
        case mileage = "Mileage"
        case kilometrage = "Kilometrage"
        case licensePlate = "License Plate"
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
        case .carType:
            return self.sorted { $0.carType < $1.carType }
        }
    }
}
