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

    @Test func validation_wrongtype() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "test"
        vm.validate()
        #expect(vm.showError == true)
        #expect(vm.canFetch == false)
    }
    
    @Test func validation_negative() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "-45"
        vm.validate()
        #expect(vm.showError == true)
        #expect(vm.canFetch == false)
    }
    
    @Test func validation_zero() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "0"
        vm.validate()
        #expect(vm.showError == true)
        #expect(vm.canFetch == false)
    }
    
    @Test func validation_largenumber() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "145"
        vm.validate()
        #expect(vm.showError == true)
        #expect(vm.canFetch == false)
    }
    
    @Test func validation_valid_100() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "100"
        vm.validate()
        #expect(vm.showError == false)
        #expect(vm.canFetch == true)
    }
    
    @Test func validation_valid_1() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "1"
        vm.validate()
        #expect(vm.showError == false)
        #expect(vm.canFetch == true)
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
        vm.validate()
        await vm.fetchVehicles()
        #expect(vm.vehicles.count == 3)
    }
    
    @Test func fetch_count_novehicles() async throws {
        let vm = VehicleListViewModel(client: RideClientMock())
        vm.fetchCount = "3"
        vm.validate()
        await vm.fetchVehicles()
        #expect(vm.vehicles.count == 0)
    }
}
