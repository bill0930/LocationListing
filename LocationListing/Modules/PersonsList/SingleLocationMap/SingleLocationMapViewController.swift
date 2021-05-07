//
//  SingleLocationMapViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import UIKit

class SingleLocationMapViewController: UIViewController {

    let person: Person

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
