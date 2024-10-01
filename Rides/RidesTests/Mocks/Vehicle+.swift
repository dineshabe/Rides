//
//  Vehicle+.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-10-01.
//

@testable import Rides

extension Vehicle {
    init(kilometrage : Int) {
        self.init(id: Int.random(in: 0..<99999), uid: "fb70a6e6-412d-4dc9-a5b3-92d003e73a4f", vin: "165TBPRF056151713", makeAndModel: Vehicle.randomModel, color: "Yellow", transmission: "Manual", driveType: "AWD", fuelType: "Compressed Natural Gas", carType: "Cargo Van", carOptions: [], specs: [], doors: 2, mileage: 56716, kilometrage: kilometrage, licensePlate: "KDX-2983")
    }
    
    init(vin: String) {
        self.init(id: Int.random(in: 0..<99999), uid: "fb70a6e6-412d-4dc9-a5b3-92d003e73a4f", vin: vin, makeAndModel: Vehicle.randomModel, color: "Yellow", transmission: "Manual", driveType: "AWD", fuelType: "Compressed Natural Gas", carType: "Cargo Van", carOptions: [], specs: [], doors: 2, mileage: 56716, kilometrage: 45674, licensePlate: "KDX-2983")
    }
    
    init(mileage: Int) {
        self.init(id: Int.random(in: 0..<99999), uid: "fb70a6e6-412d-4dc9-a5b3-92d003e73a4f", vin: "165TBPRF056151713", makeAndModel: Vehicle.randomModel, color: "Yellow", transmission: "Manual", driveType: "AWD", fuelType: "Compressed Natural Gas", carType: "Cargo Van", carOptions: [], specs: [], doors: 2, mileage: mileage, kilometrage: 45674, licensePlate: "KDX-2983")
    }
    
    init(licensePlate: String) {
        self.init(id: Int.random(in: 0..<99999), uid: "fb70a6e6-412d-4dc9-a5b3-92d003e73a4f", vin: "165TBPRF056151713", makeAndModel: Vehicle.randomModel, color: "Yellow", transmission: "Manual", driveType: "AWD", fuelType: "Compressed Natural Gas", carType: "Cargo Van", carOptions: [], specs: [], doors: 2, mileage: 45674, kilometrage: 45674, licensePlate: licensePlate)
    }
    
    private static var randomModel: String {
        let models = ["Chevy Silverado", "BMW M5", "Chevy Malibu", "Dodge Ram", "Buick Riveria"]
        let randomInt = Int.random(in: 0..<4)
        return models[randomInt]
    }
}
