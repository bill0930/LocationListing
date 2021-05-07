//
//  Person.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import Foundation
import ObjectMapper
import RealmSwift

class Person: Object, Mappable {

    @objc dynamic var id: String = ""
    @objc dynamic var picture: String = ""
    @objc dynamic var name: PersonName!
    @objc dynamic var email: String = ""
    @objc dynamic var location: LatLon!

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id          <-  map["_id"]
        picture     <-  map["picture"]
        name        <-  map["name"]
        email       <-  map["email"]
        location    <-  map["location"]
    }

}
