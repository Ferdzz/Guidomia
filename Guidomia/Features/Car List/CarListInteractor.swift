//
//  CarListInteractor.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import UIKit

protocol CarListInteractorProtocol: AnyObject {
    func onViewDidLoad()
}

class CarListInteractor {
    private let carsStore = CarsStore()
    
    private weak var viewController: CarListViewControllerProtocol?
    
    init(viewController: CarListViewControllerProtocol) {
        self.viewController = viewController
    }
    
    private func fetchData() async {
        // TODO: This should present a loading indicator
        let result = await self.carsStore.getCars()
        switch result {
        case let .success(cars):
            // TODO: Move the making of these rows to factories
            var carRows = cars.flatMap({
                return [
                    CarListRow.car(item: .init(
                        carImage: $0.image,
                        carName: $0.model,
                        // Formatting using a divided string could be improved by moving to an extension supporting
                        // millions and billions as well
                        carPrice: String(format: NSLocalizedString("CarList.Price", comment: ""), Int($0.customerPrice / 1000)),
                        carRating: Double($0.rating),
                        // The JSON data contains empty pros & cons items. Filter these out as well
                        prosList: $0.prosList.filter({ !$0.isEmpty }),
                        consList: $0.consList.filter({ !$0.isEmpty }),
                        isExpanded: false
                    )),
                    CarListRow.separator
                ]
            })
            // Remove the last separator cell as there is no car below it
            carRows.removeLast()
            // The first item in the list is expanded by default
            switch carRows.first {
            case var .car(item):
                item.isExpanded = true
                carRows[0] = .car(item: item)
            default: break
            }
            
            viewController?.showData(sections: [
                .init(rows: [
                    CarListRow.header(item: .init(
                        backgroundImage: UIImage(named: "Tacoma") ?? UIImage(),
                        title: "Tacoma 2021",
                        subtitle: NSLocalizedString("CarList.Header.CallToAction", comment: "")))
                ]),
                .init(rows: [.filter]),
                .init(rows: carRows)
            ])
        case let .failure(error):
            // TODO: Show error
            break
        }
    }
}

extension CarListInteractor: CarListInteractorProtocol {
    func onViewDidLoad() {
        viewController?.showData(sections: [.init(rows: [
            .header(item: .init(
                backgroundImage: UIImage(named: "Tacoma") ?? UIImage(),
                title: "Tacoma 2021",
                subtitle: NSLocalizedString("CarList.Header.CallToAction", comment: "")))
        ])])
        
        // Request the data asynchronously
        Task {
            await self.fetchData()
        }
    }
}
