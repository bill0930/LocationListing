//
//  TabBarViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import Moya

private struct Constants {
    static let personListViewTitle = "List View"
    static let personListViewImage = UIImage(systemName: "info.circle")
    static let personListViewSelectedImage = UIImage(systemName: "info.circle.fill")

    static let multiLocViewTitle = "Map View"
    static let multiLocViewImage = UIImage(systemName: "map")
    static let multiLocViewSelectedImage = UIImage(systemName: "map.fill")

    static let tabBarTintColor = UIColor(named: "pink001")
    static let tabBarBarTintColor = UIColor(named: "pink005")
    static let tabBarBarForegroundColor = UIColor(named: "pink001")
    static let tabBarBarFont = UIFont(name: "Avenir Book", size: 14.0)

}

final class TabBarController: UITabBarController {

    lazy private var personListVC: PersonListViewController = {
        let viewModel = PersonListViewModel()
        let viewController = PersonListViewController(viewModel: viewModel)
        let tabBarItem = UITabBarItem(title: Constants.personListViewTitle,
                                      image: Constants.personListViewImage,
                                      selectedImage: Constants.personListViewSelectedImage)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    lazy private var multiLocationVC: MultiLocationMapViewController = {
        let viewModel = MultiLocationMapViewModel()
        let viewController = MultiLocationMapViewController(viewModel: viewModel)
        let tabBarItem = UITabBarItem(title: Constants.multiLocViewTitle,
                                      image: Constants.multiLocViewImage,
                                      selectedImage: Constants.multiLocViewSelectedImage)

        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBar.tintColor = Constants.tabBarTintColor
        tabBar.barTintColor = Constants.tabBarBarTintColor

        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor: Constants.tabBarBarForegroundColor!,
            .font: Constants.tabBarBarFont!
        ], for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [personListVC, multiLocationVC]
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
