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
    var isLoading: Bool { get set }
    var isFetchFromCache: Bool { get set }

    var updateLoadingStatus: ((Bool) -> Void)? { get set }
    var didFinishFetch: (() -> Void)? { get set }
    var didFetchFromCache: (() -> Void)? { get set }

    func pullToRefresh()
    func retrievePersonList(completion: (([Person]) -> Void)?)
}

final class PersonsListViewModel: PersonsListViewModelProtocol {

    var storageService: StorageServiceProtocol = StorageService()

    var persons: [Person] = [] {
        didSet {
            DispatchQueue.main.async {
                self.didFinishFetch?()
                self.isLoading = false
            }

        }
    }

    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.updateLoadingStatus?(self.isLoading)
            }
        }
    }

    var isFetchFromCache: Bool = false {
        willSet(value) {
            DispatchQueue.main.async {
                if value == true {
                    self.didFetchFromCache?()
                }
            }
        }
    }

    // closures
    var updateLoadingStatus: ((Bool) -> Void)?
    var didFinishFetch: (() -> Void)?
    var didFetchFromCache: (() -> Void)?

    func retrievePersonList(completion: (([Person]) -> Void)?) {
        isLoading = true
        storageService.retrievePersonlistFrom(.remote) { [weak self] persons, isFetchFromCache in
            guard let strongSelf = self else { return }
            strongSelf.persons = persons
            strongSelf.isFetchFromCache = isFetchFromCache
        }
    }

    func pullToRefresh() {
        self.retrievePersonList(completion: nil)
    }
}
