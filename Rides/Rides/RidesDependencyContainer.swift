//
//  RidesDependencyContainer.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-10-02.
//

final class RidesDependencyContainer {
    
    lazy var rideClient: RidesClient = {
        //Return right client based on environoment
        RidesClient()
    }()
}
