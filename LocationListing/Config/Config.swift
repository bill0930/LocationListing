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
            return "AIzaSyCZnbYyUI9-cXWCehp4tbFeZ73PteIG0Nw"
        }
    }
}