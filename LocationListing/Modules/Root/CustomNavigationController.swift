//
//  CustomNavigationController.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "pink001")!,
            .font: UIFont(name: "Avenir Black", size: 24.0)!
        ]
        navigationBar.barTintColor = UIColor(named: "pink005")
        navigationBar.tintColor = UIColor(named: "pink003")
    }

}
