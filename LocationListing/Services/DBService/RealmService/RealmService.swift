//
//  RealmService.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation
import RealmSwift

// protocol RealmServiceProtocol {
//    var db: Realm? { get set }
//    func configSDK()
// }

class RealmService {

    static let shared = RealmService()

    var realm: Realm

    private init() {
        if let realm = try? Realm(configuration: RealmService.config) {
            print("Realm Init succedd with \(realm.configuration.fileURL?.absoluteURL)")
            self.realm = realm
        } else {
            fatalError("RealmDB config fails")
        }
    }

    static var config: Realm.Configuration {
        let username = "LocationListing"
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(username)
        config.fileURL!.appendPathExtension("realm")
        config.encryptionKey = nil

        return config
    }

}
