//
//  CarsLocalManagerTests.swift
//  GuidomiaTests
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import XCTest
@testable import Guidomia

class CarsLocalManagerTests: XCTestCase {

    /// Test that getting cars from local manager works
    func testGetCars() async throws {
        let manager = CarsLocalManager()
        
        let cars = try await manager.getCars().get()
        
        let expectedResult = [
            Guidomia.Car(customerPrice: 120000.0, make: "Land Rover", model: "Range Rover", consList: ["Bad direction"], prosList: ["You can go everywhere", "Good sound system"], rating: 3, image: "Range_Rover.jpg"),
            Guidomia.Car(customerPrice: 220000.0, make: "Alpine", model: "Roadster", consList: ["Sometime explode"], prosList: ["This car is so fast", "Jame Bond would love to steal that car", "", ""], rating: 4, image: "Alpine_roadster.jpg"),
            Guidomia.Car(customerPrice: 65000.0, make: "BMW", model: "3300i", consList: ["You can heard the engine over children cry at the back", "", "You may lose this one if you divorce"], prosList: ["Your average business man car", "Can bring the family home safely", "The city must have"], rating: 5, image: "BMW_330i.jpg"),
            Guidomia.Car(customerPrice: 95000.0, make: "Mercedes Benz", model: "GLE coupe", consList: ["You may lose a wheel", "Expensive maintenance"], prosList: [], rating: 2, image: "Mercedez_benz_GLC.jpg")
        ]
        XCTAssertEqual(expectedResult, cars)
    }
    
    /// Test that getting cars from a non-existing file returns an error
    func testGetCarsNoFile() async throws {
        let manager = CarsLocalManager()
        
        let cars = await manager.getCars(carListFileName: "ThisFileDoesntExist")
        
        switch cars {
        case .failure:
            break
        case .success:
            XCTFail("Expected error from not found file")
        }
    }
    
}
