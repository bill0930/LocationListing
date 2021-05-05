//
//  PersonLatLon.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation

struct LatLon {
    let latitude: Float?
    let longitude: Float?
}

extension LatLon: Decodable {
    enum LatLonCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LatLonCodingKeys.self)

        latitude = try container.decode(Float?.self, forKey: .latitude)
        longitude = try container.decode(Float?.self, forKey: .longitude)
    }
}
