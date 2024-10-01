//
//  DoubleTest.swift
//  RidesTests
//
//  Created by Dinesh Thangasamy on 2024-10-01.
//

import Testing
@testable import Rides

struct DoubleTest {

    @Test func pretty_nodecimal() async throws {
        let double = 1.0
        #expect(double.pretty == "1")
    }
    
    @Test func pretty_onedecimal() async throws {
        let double = 1.1
        #expect(double.pretty == "1.1")
    }
    
    @Test func pretty_multipledecimal() async throws {
        let double = 1.143563
        #expect(double.pretty == "1.14")
    }
    
    @Test func pretty_largeNumber() async throws {
        let double = 45678.0
        #expect(double.pretty == "45,678")
    }
}
