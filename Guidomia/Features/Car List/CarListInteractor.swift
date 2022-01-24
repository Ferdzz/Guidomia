//
//  CarListInteractor.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import UIKit

protocol CarListInteractorProtocol: AnyObject {
    func onViewDidLoad()
    func didSelectMake(value: String?)
    func didSelectModel(value: String?)
}

class CarListInteractor {
    private let carsStore = CarsStore()
    
    private weak var viewController: CarListViewControllerProtocol?
    
    private var cars: [Car]?
    private var filteringMake: String?
    private var filteringModel: String?
    
    init(viewController: CarListViewControllerProtocol) {
        self.viewController = viewController
    }
    
    /// Fetches the list of cars and orders the view to display the results
    private func fetchData() async {
        self.viewController?.showLoading()
        let result = await self.carsStore.getCars()
        // Uncomment this line to display the loading indicator:
        // try! await Task.sleep(nanoseconds: 4000000000)
        self.viewController?.hideLoading()
        switch result {
        case let .success(cars):
            self.cars = cars
            self.showData(cars: cars)
        case let .failure(error):
            self.viewController?.showError(error: error)
        }
    }
    
    /// Orders the view to display the list of cars. Filters the list provided using `filteringMake` & `filteringModel`
    private func showData(cars: [Car]) {
        // Filter car list with the filtering values
        let filteredCars = cars.filter({
            if let filteringMake = self.filteringMake, $0.make != filteringMake {
                return false
            }
            if let filteringModel = self.filteringModel, $0.model != filteringModel {
                return false
            }
            return true
        })
        
        self.viewController?.showData(sections: [
            .init(rows: [CarListRowFactory.makeHeader()]),
            .init(rows: [CarListRowFactory.makeFilter(cars: cars)]),
            .init(rows: CarListRowFactory.makeCars(cars: filteredCars))
        ])

    }
}

extension CarListInteractor: CarListInteractorProtocol {
    func onViewDidLoad() {
        self.viewController?.showData(sections: [
            .init(rows: [CarListRowFactory.makeHeader()])
        ])
        
        // Request the data asynchronously
        Task {
            await self.fetchData()
        }
    }
    
    func didSelectMake(value: String?) {
        guard let cars = self.cars else { return }
        self.filteringMake = value
        self.showData(cars: cars)
    }
    
    func didSelectModel(value: String?) {
        guard let cars = self.cars else { return }
        self.filteringModel = value
        self.showData(cars: cars)
    }
}
