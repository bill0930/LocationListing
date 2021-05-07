//
//  PersonsListViewModelProtocol.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import ObjectMapper

protocol PersonsListViewModelProtocol: AnyObject {
    var storageService: StorageServiceProtocol { get }

    var persons: [Person] { get set }

    var updateLoadingStatus: ((Bool) -> Void)? { get set }
    var didFinishFetch: (() -> Void)? { get set }

    func pullToRefresh()
    func retrievePersonList(completion: (([Person]) -> Void)?)
}

final class PersonsListViewModel: PersonsListViewModelProtocol {

    var storageService: StorageServiceProtocol

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
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
        storageService.retrievePersonlist { [weak self] persons in
            guard let strongSelf = self else { return }
            strongSelf.persons = persons
        }
    }

    func pullToRefresh() {
        self.retrievePersonList(completion: nil)
    }
}
