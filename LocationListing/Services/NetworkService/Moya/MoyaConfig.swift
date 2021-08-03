//
//  APIService.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import Moya
class MoyaConfig {
    static func JSONResponseDataFormatter(_ data: Data) -> String {x
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }

    static var pluginType = NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                     logOptions: .verbose))

    static func defaultAlamofireSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 5.0
        configuration.timeoutIntervalForResource = 5.0

        return Session(configuration: configuration, startRequestsImmediately: false)
    }
}
