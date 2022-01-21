//
//  CarsLocalManager.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

class CarsLocalManager: CarsManagerProtocol {
    
    private let decoder = JSONDecoder()
    
    public func getCars() async -> Result<[Car], Error> {
        return await getCars(carListFileName: "car_list")
    }
    
    public func getCars(carListFileName: String) async -> Result<[Car], Error> {
        // Get the path to the car_list file
        guard let path = Bundle.main.path(forResource: carListFileName, ofType: "json") else {
            return Result.failure(GuidomiaError.cannotFindFile)
        }
        
        do {
            // Attempt to decode the Car data into model objects
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let cars = try decoder.decode([Car].self, from: data)
            return Result.success(cars)
        } catch {
            return Result.failure(error)
        }
    }
}
