//
//  PersonLatLon.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import ObjectMapper
import RealmSwift

class LatLon: Object, Mappable {

    @objc dynamic var latitude = 0.0
    var longitude = RealmOptional<Double>()

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }

}
