//
//  Car.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

struct Car: Decodable, Equatable {
    let customerPrice: Double
    let make: String
    let model: String
    let consList: [String]
    let prosList: [String]
    let rating: Int
}
