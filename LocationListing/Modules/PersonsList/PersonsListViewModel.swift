//
//  PersonsListViewModelProtocol.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation

protocol PersonsListViewModelProtocol: AnyObject {
    var apiService: APIServiceProtocol? { get }

    var persons: [Person] { get set }

    var updateLoadingStatus: ((Bool) -> Void)? { get set }
    var didFinishFetch: (() -> Void)? { get set }

    func getPersonList()
}

final class PersonsListViewModel: PersonsListViewModelProtocol {
    var apiService: APIServiceProtocol?

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

    func getPersonList() {
        isLoading = true
        DispatchQueue.main.async { [ weak self ] in
            self?.apiService?.DAPI.request(.personsList) { [weak self] result in
                switch result {
                case .success(let response):
                    if let persons = try? response.map([Person].self) {
                        self?.persons = persons
                    }

                case .failure(let error):
                    self?.persons = self?.persons ?? []
                }
            }
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
}
