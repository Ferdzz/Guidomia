//
//  CarsStore.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

class CarsStore {
    
    private let localManager = CarsLocalManager()
    private let apiManager = CarsApiManager()
    
    /// Gets the list of cars
    func getCars() async -> Result<[Car], Error> {
        // In a real world scenario, the Store's role would be to choose where the data comes from. Depending
        // on the situation, it may want to forward the request to the local manager, API manager, memory storage
        // or persistent storage.
        //
        // In the case of this example, there is no API so we always fetch the data from the local manager. I
        // added files for the API manager to showcase the theoretical structure of a full app.
        return await self.localManager.getCars()
    }
}
