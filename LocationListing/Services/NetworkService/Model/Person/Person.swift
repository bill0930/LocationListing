//
//  Person.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation

struct Person {
    let id: String
    let picture: String
    let name: PersonName
    let email: String
    let location: LatLon
}

extension Person: Decodable {
    enum PersonCodingKeys: String, CodingKey {
        case id = "_id"
        case picture
        case name
        case email
        case location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonCodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        picture = try container.decode(String.self, forKey: .picture)
        name = try container.decode(PersonName.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        location = try container.decode(LatLon.self, forKey: .location)

    }
}
