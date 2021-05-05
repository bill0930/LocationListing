//
//  APIService.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import Moya

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

private var pluginType = NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                              logOptions: .verbose))

func defaultAlamofireSession() -> Session {
    let configuration = URLSessionConfiguration.default
    configuration.headers = .default
    configuration.timeoutIntervalForRequest = 20.0
    configuration.timeoutIntervalForResource = 20.0

    return Session(configuration: configuration, startRequestsImmediately: false)
}

protocol APIServiceProtocol {
    var DAPI: MoyaProvider<DAPI> { get }
}

final class APIService: APIServiceProtocol {
    var DAPI = MoyaProvider<DAPI>(session: defaultAlamofireSession(),
                                  plugins: [pluginType])
}
