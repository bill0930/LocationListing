//
//  StorageService.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation

protocol StorageServiceProtocol: AnyObject {
    var realmService: RealmService { get set }
    var apiService: APIServiceProtocol { get set }
    func retrievePersonlist(completion: (([Person]) -> Void)?)
}

class StorageService: StorageServiceProtocol {

    internal var realmService: RealmService = RealmService.shared
    internal var apiService: APIServiceProtocol = APIService()

    func retrievePersonlist(completion: (([Person]) -> Void)?) {
        apiService.dapiService.getPersonList(completion: { [weak self] persons in
            guard let strongSelf = self else { return }
            var result: [Person] = []
            if !persons.isEmpty {
                try? strongSelf.realmService.realm.write {
                    strongSelf.realmService.realm.add(persons, update: .modified)
                }
                result = persons
            } else {
                let personsFromRealm = Array(strongSelf.realmService.realm.objects(Person.self))
                if !personsFromRealm.isEmpty {
                    result = personsFromRealm
                }
            }
            completion?(result)
        })
    }

}
