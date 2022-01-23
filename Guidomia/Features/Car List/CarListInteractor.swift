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
            viewController?.showData(sections: [
                .init(rows: [CarListRowFactory.makeHeader()]),
                .init(rows: [CarListRowFactory.makeFilter()]),
                .init(rows: CarListRowFactory.makeCars(cars: cars))
            ])
        case let .failure(error):
            // TODO: Show error
            break
        }
    }
}

extension CarListInteractor: CarListInteractorProtocol {
    func onViewDidLoad() {
        viewController?.showData(sections: [
            .init(rows: [CarListRowFactory.makeHeader()])
        ])
        
        // Request the data asynchronously
        Task {
            await self.fetchData()
        }
    }
}
