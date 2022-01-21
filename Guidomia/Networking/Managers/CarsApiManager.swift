//
//  CarsApiManager.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

class CarsApiManager: CarsManagerProtocol {
    
    func getCars() async -> Result<[Car], Error> {
        assertionFailure("API fetching of cars is not yet implemented. See details in CarsStore.swift")
        return Result.failure(GuidomiaError.notImplemented)
    }
}
