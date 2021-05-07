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
    func getPersonList(completion: (([Person]) -> Void)?)
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

    func getPersonList(completion: ( (_ persons: [Person]) -> Void)?) {
        isLoading = true
        DispatchQueue.main.async { [ weak self ] in
            self?.apiService?.DAPI.request(.personsList) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let response):
                    if let json = try? response.mapJSON() {
                        if let persons = Mapper<Person>().mapArray(JSONObject: json) {
                            strongSelf.persons = persons
                            completion?(persons)
                        }
                    } else {
                        strongSelf.persons = []
                        completion?([])
                    }

                case .failure(let error):
                    print("DPI.get.personsList failure with \(error.localizedDescription)")
                    completion?(strongSelf.persons)
                }
            }
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
}
