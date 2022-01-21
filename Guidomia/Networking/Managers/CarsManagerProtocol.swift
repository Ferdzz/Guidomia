//
//  CarsManagerProtocol.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

protocol CarsManagerProtocol {
    func getCars() async -> Result<[Car], Error>
}
