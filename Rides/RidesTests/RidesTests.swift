//
//  RidesTests.swift
//  RidesTests
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import Testing
@testable import Rides

struct RidesTests {

    @Test func fetch_validation_wrongtype() async throws {
        let vm = VehicleListViewModel(client: RidesClient())
        vm.fetchCount = "test"
        vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_negative() async throws {
        let vm = VehicleListViewModel(client: RidesClient())
        vm.fetchCount = "-45"
        vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_zero() async throws {
        let vm = VehicleListViewModel(client: RidesClient())
        vm.fetchCount = "0"
        vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_largenumber() async throws {
        let vm = VehicleListViewModel(client: RidesClient())
        vm.fetchCount = "145"
        vm.fetchVehicles()
        #expect(vm.displayError == true)
    }
    
    @Test func fetch_validation_valid_100() async throws {
        let vm = VehicleListViewModel(client: RidesClient())
        vm.fetchCount = "100"
        vm.fetchVehicles()
        #expect(vm.displayError == false)
    }
    
    @Test func fetch_validation_valid_1() async throws {
        let vm = VehicleListViewModel(client: RidesClient())
        vm.fetchCount = "1"
        vm.fetchVehicles()
        #expect(vm.displayError == false)
    }
}
