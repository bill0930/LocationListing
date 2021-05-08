//
//  Config.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation

enum Config {
    case googleMapSDK

    var APIKey: String {
        switch self {
        case .googleMapSDK:
            return <#GoogleMapSDK API KEY#>
        }
    }
}
