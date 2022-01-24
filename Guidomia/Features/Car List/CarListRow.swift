//
//  CarListRow.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import UIKit

enum CarListRow {
    case header(item: CarListHeaderTableViewCell.Item)
    case filter(item: FilterTableViewCell.Item)
    case car(item: CarTableViewCell.Item)
    case separator
}

final class CarListRowFactory {
    
    static func makeHeader() -> CarListRow {
        return .header(item: .init(
            backgroundImage: UIImage(named: "Tacoma") ?? UIImage(),
            title: "Tacoma 2021",
            subtitle: NSLocalizedString("CarList.Header.CallToAction", comment: "")))
    }
    
    static func makeFilter(cars: [Car]) -> CarListRow {
        return .filter(item: .init(
            makes: [NSLocalizedString("CarList.Filter.Make", comment: "")] + cars.map({ $0.make }),
            models: [NSLocalizedString("CarList.Filter.Model", comment: "")] + cars.map({ $0.model })))
    }

    static func makeCars(cars: [Car]) -> [CarListRow] {
        // Aggregate all car rows and append them with a separator cell
        var carRows = cars.flatMap({
            [self.makeCar(car: $0), self.makeSeparator()]
        })
        // Remove the last separator cell as there is no car below it
        if !carRows.isEmpty {
            carRows.removeLast()            
        }
        // The first item in the list is expanded by default
        switch carRows.first {
        case var .car(item):
            item.isExpanded = true
            carRows[0] = .car(item: item)
        default: break
        }
        
        return carRows
    }
    
    static func makeCar(car: Car) -> CarListRow {
        return CarListRow.car(item: .init(
            carImage: car.image,
            carName: car.model,
            // Formatting using a divided string could be improved by moving to an extension supporting
            // millions and billions as well
            carPrice: String(format: NSLocalizedString("CarList.Price", comment: ""), Int(car.customerPrice / 1000)),
            carRating: Double(car.rating),
            // The JSON data contains empty pros & cons items. Filter these out as well
            prosList: car.prosList.filter({ !$0.isEmpty }),
            consList: car.consList.filter({ !$0.isEmpty }),
            isExpanded: false
        ))
    }
    
    static func makeSeparator() -> CarListRow {
        return .separator
    }
}
