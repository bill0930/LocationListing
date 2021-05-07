//
//  DAPIService.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation
import Moya
import ObjectMapper
import Realm
import RealmSwift

protocol DAPIServiceProtocol {
    var provider: MoyaProvider<DAPI> { get }
    func getPersonList(completion: (([Person]) -> Void)?)
}

final class DAPIService: DAPIServiceProtocol {

    var realm = RealmService.shared.realm

    var provider = MoyaProvider<DAPI>(session: MoyaConfig.defaultAlamofireSession(),
                                  plugins: [MoyaConfig.pluginType])

    func getPersonList(completion: (([Person]) -> Void)?) {
        self.provider.request(.personsList) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON() {
                    if let persons = Mapper<Person>().mapArray(JSONObject: json) {
                        completion?(persons)
                        try? strongSelf.realm.write {
                            strongSelf.realm.add(persons, update: .all)
                        }
                    } else {
                        completion?([])
                    }
                } else {
                    completion?([])
                }
            case .failure(let error):
                completion?([])
                print(error.localizedDescription)
            }
        }
    }
}
