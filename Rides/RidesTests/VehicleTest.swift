//
//  VehicleTest.swift
//  RidesTests
//
//  Created by Dinesh Thangasamy on 2024-10-01.
//

import Testing
@testable import Rides

struct VehicleTest {
    
    @Test func emission_lower() async throws {
        let testVehicle = Vehicle(kilometrage: 4000)
        let emissions = testVehicle.getEmissions()
        #expect(emissions == 4000) //Rate is 1
    }
    
    @Test func emission_zero() async throws {
        let testVehicle = Vehicle(kilometrage: 0)
        let emissions = testVehicle.getEmissions()
        #expect(emissions == 0) //Rate is 1
    }
    
    @Test func emission_negative() async throws {
        let testVehicle = Vehicle(kilometrage: -456)
        let emissions = testVehicle.getEmissions()
        #expect(emissions == 0) //Rate is 1
    }
    
    @Test func emission_higher() async throws {
        let testVehicle = Vehicle(kilometrage: 6000)
        let emissions = testVehicle.getEmissions()
        #expect(emissions == 6500) //Rate is 1 & 1.5
    }
    
    @Test func sort_vin() async throws {
        let vehicles = [
            Vehicle(vin: "474HT5794F9312855"),
            Vehicle(vin: "474HT5794F9312852"),
            Vehicle(vin: "474HT5794F9312858"),
            Vehicle(vin: "474HT5794F9312859"),
            Vehicle(vin: "474HT5794F9312851")
        ].sort(key: .vin)
                
        #expect(vehicles[0].vin == "474HT5794F9312851")
        #expect(vehicles[1].vin == "474HT5794F9312852")
        #expect(vehicles[2].vin == "474HT5794F9312855")
        #expect(vehicles[3].vin == "474HT5794F9312858")
        #expect(vehicles[4].vin == "474HT5794F9312859")
    }
    
    @Test func sort_mileage() async throws {
        let vehicles = [
            Vehicle(mileage: 62999),
            Vehicle(mileage: 52999),
            Vehicle(mileage: 62980),
            Vehicle(mileage: 64599),
            Vehicle(mileage: 629),
        ].sort(key: .mileage)
                
        #expect(vehicles[0].mileage == 629)
        #expect(vehicles[1].mileage == 52999)
        #expect(vehicles[2].mileage == 62980)
        #expect(vehicles[3].mileage == 62999)
        #expect(vehicles[4].mileage == 64599)
    }
    
    @Test func sort_kilometrage() async throws {
        let vehicles = [
            Vehicle(kilometrage: 62999),
            Vehicle(kilometrage: 52999),
            Vehicle(kilometrage: 62980),
            Vehicle(kilometrage: 64599),
            Vehicle(kilometrage: 629),
        ].sort(key: .kilometrage)
                
        #expect(vehicles[0].kilometrage == 629)
        #expect(vehicles[1].kilometrage == 52999)
        #expect(vehicles[2].kilometrage == 62980)
        #expect(vehicles[3].kilometrage == 62999)
        #expect(vehicles[4].kilometrage == 64599)
    }
    
    @Test func sort_licensePlate() async throws {
        let vehicles = [
            Vehicle(licensePlate: "CHW-8617"),
            Vehicle(licensePlate: "CHW-8611"),
            Vehicle(licensePlate: "CHW-8613"),
            Vehicle(licensePlate: "CHW-8618"),
            Vehicle(licensePlate: "CHW-8610"),
        ].sort(key: .licensePlate)
                
        #expect(vehicles[0].licensePlate == "CHW-8610")
        #expect(vehicles[1].licensePlate == "CHW-8611")
        #expect(vehicles[2].licensePlate == "CHW-8613")
        #expect(vehicles[3].licensePlate == "CHW-8617")
        #expect(vehicles[4].licensePlate == "CHW-8618")
    }
}
