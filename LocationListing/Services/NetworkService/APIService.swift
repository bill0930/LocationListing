//
//  APIService.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation
import Moya

// MARK: Centralized all API Service

protocol APIServiceProtocol {
    var dapiService: DAPIServiceProtocol { get set }
}

final class APIService: APIServiceProtocol {
    var dapiService: DAPIServiceProtocol = DAPIService()
    init() {}
}
