//
//  StorageService.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation

enum DataSource {
    case cache
    case remote
}

protocol StorageServiceProtocol: AnyObject {
    var realmService: RealmService { get set }
    var apiService: APIServiceProtocol { get set }
    func retrievePersonlistFrom(_ dataSource: DataSource, completion: (([Person], _ isFetchFromCache: Bool) -> Void)?)
}

class StorageService: StorageServiceProtocol {

    internal var realmService: RealmService = RealmService.shared
    internal var apiService: APIServiceProtocol = APIService()

    func retrievePersonlistFrom(_ dataSource: DataSource, completion: (([Person], _ isFetchFromCache: Bool) -> Void)?) {
        switch dataSource {
        case .cache:
            let personsFromRealm = Array(realmService.realm.objects(Person.self))
            completion?(personsFromRealm, true)
            return
        case .remote:
            apiService.dapiService.getPersonList(completion: { [weak self] persons in
                guard let strongSelf = self else { return }
                if !persons.isEmpty {
                    try? strongSelf.realmService.realm.write {
                        strongSelf.realmService.realm.add(persons, update: .modified)
                    }
                    completion?(persons, false)
                } else {
                    strongSelf.retrievePersonlistFrom(.cache, completion: completion)
                }
            })
        }
    }

}
