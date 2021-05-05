//
//  PersonName.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation

struct PersonName {
    let first: String?
    let last: String?
}

extension PersonName: Decodable {
    enum PersonNameCodingKeys: String, CodingKey {
        case first
        case last
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonNameCodingKeys.self)

        first = try container.decode(String?.self, forKey: .first)
        last = try container.decode(String?.self, forKey: .last)
    }
}
