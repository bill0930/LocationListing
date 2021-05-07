//
//  SingleLocationMapViewModel.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import Foundation
protocol SingleLocationMapViewModelProtocol {
    var person: Person { get set }
}
class SingleLocationMapViewModel: SingleLocationMapViewModelProtocol {
    var person: Person

    init(person: Person) {
        self.person = person
    }
}
