//
//  PersonsListViewModelProtocol.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import ObjectMapper

protocol PersonsListViewModelProtocol: AnyObject {
    var apiService: APIServiceProtocol? { get }

    var persons: [Person] { get set }

    var updateLoadingStatus: ((Bool) -> Void)? { get set }
    var didFinishFetch: (() -> Void)? { get set }

    func pullToRefresh()
    func retrievePersonList(completion: (([Person]) -> Void)?)
}

final class PersonsListViewModel: PersonsListViewModelProtocol {

    var apiService: APIServiceProtocol?

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    var persons: [Person] = [] {
        didSet {
            didFinishFetch?()
            isLoading = false
        }
    }

    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?(isLoading)
        }
    }

    // closures
    var updateLoadingStatus: ((Bool) -> Void)?
    var didFinishFetch: (() -> Void)?

    func retrievePersonList(completion: (([Person]) -> Void)?) {
        isLoading = true
        apiService?.dapiService.getPersonList(completion: { [weak self ] persons in
            self?.persons = persons
            completion?(persons)
        })
    }

    func pullToRefresh() {
        self.retrievePersonList(completion: nil)
    }
}
