//
//  CustomNavigationController.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//

import UIKit

private struct Constants {
    static let navBarTextColor = UIColor(named: "pink001")!
    static let navBarFont = UIFont(name: "Avenir Black", size: 24.0)!
    static let navBarBarTintColor = UIColor(named: "pink005")!
    static let navBarTintColor = UIColor(named: "pink003")!

}

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [
            .foregroundColor: Constants.navBarTextColor,
            .font: Constants.navBarFont
        ]
        navigationBar.barTintColor = Constants.navBarBarTintColor
        navigationBar.tintColor = Constants.navBarTintColor
    }

}
