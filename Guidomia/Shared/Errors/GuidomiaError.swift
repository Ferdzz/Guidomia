//
//  GuidomiaError.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

enum GuidomiaError: LocalizedError {
    case cannotFindFile
    case notImplemented
    
    var errorDescription: String? {
        switch self {
        case .cannotFindFile, .notImplemented:
            return NSLocalizedString("Error.CannotLoadCars", comment: "")
        }
    }
}
