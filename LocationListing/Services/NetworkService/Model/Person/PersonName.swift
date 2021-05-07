//
//  PersonName.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import ObjectMapper
import RealmSwift

class PersonName: EmbeddedObject, Mappable {

    @objc dynamic var first: String?
    @objc dynamic var last: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        first <- map["first"]
        last <- map["last"]
    }

}
