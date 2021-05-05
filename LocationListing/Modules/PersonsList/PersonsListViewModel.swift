//
//  PersonsListViewModelProtocol.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation

protocol PersonsListViewModelProtocol: AnyObject {
    var apiService: APIServiceProtocol? { get }

    var persons: [Person] { get }

    var showAlertClosure: (() -> Void)? { get set }
    var updateLoadingStatus: (() -> Void)? { get set }
    var didFinishFetch: (() -> Void)? { get set }

    func getPersonList()
}

final class PersonsListViewModel: PersonsListViewModelProtocol {
    var apiService: APIServiceProtocol?

    var persons: [Person] = [] {
        didSet {
            didFinishFetch?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }

    // closures
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var didFinishFetch: (() -> Void)?

    func getPersonList() {
        isLoading = true
        apiService?.DAPI.request(.personsList) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                if let persons = try? response.map([Person].self) {
                    self?.persons = persons
                }

            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
}
