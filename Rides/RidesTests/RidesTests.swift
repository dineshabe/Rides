//
//  RidesTests.swift
//  RidesTests
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import Testing
@testable import Rides

struct RidesTests {
    
    final private class RideClientMock: RideClientProtocol {
        func fetchVehicles(count: Int) async throws -> [Rides.Vehicle] {
            return []
        }
    }

    @Test func fetch_validation_wrongtype() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "test"
        await vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_negative() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "-45"
        await vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_zero() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "0"
        await vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_largenumber() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "145"
        await vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_valid_100() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "100"
        await vm.fetchVehicles()
        #expect(vm.displayError == false)
    }
    
    @Test func fetch_validation_valid_1() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "1"
        await vm.fetchVehicles()
        #expect(vm.displayError == false)
    }
    
    @Test func fetch_count() async throws {
        
        //Overriding mock implementation to return some vehicle information
        class RideClientMock: RideClientProtocol {
            func fetchVehicles(count: Int) async throws -> [Rides.Vehicle] {
                var result: [Vehicle] = []
                for i in 0..<count {
                    result.append(Vehicle(kilometrage: i * 10000))
                }
                return result
            }
        }
        
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "3"
        await vm.fetchVehicles()
        #expect(vm.displayError == false)
        #expect(vm.vehicles.count == 3)
    }
}
