//
//  TabBarViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import Moya

final class TabBarController: UITabBarController {

    lazy private var personListVC: PersonsListViewController = {
        let apiService = APIService()
        let viewModel = PersonsListViewModel(apiService: apiService)
        let viewController = PersonsListViewController(viewModel: viewModel)
        viewController.title = "List View"
        return viewController
    }()

    lazy private var firstVC: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: personListVC)
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "pink001")!,
            .font: UIFont(name: "Avenir Black", size: 24.0)!
        ]
        navigationController.navigationBar.barTintColor = UIColor(named: "pink005")
        navigationController.navigationBar.tintColor = UIColor(named: "pink005")

        let image = UIImage(systemName: "info.circle")
        let selectedImage = UIImage(systemName: "info.circle.fill")
        let tabBarItem = UITabBarItem(title: personListVC.title, image: image, selectedImage: selectedImage)
        tabBar.tintColor = UIColor(named: "pink001")
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }()

    lazy private var secondVC: MultiLocationMapViewController = {
        let viewController = MultiLocationMapViewController()
        let title = "Map View"
        let image = UIImage(systemName: "map")
        let selectedImage = UIImage(systemName: "map.fill")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)

        tabBarItem.title = title
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBar.tintColor = UIColor(named: "pink001")
        tabBar.barTintColor = UIColor(named: "pink005")

        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor(named: "pink001")!,
            .font: UIFont(name: "Avenir Book", size: 14.0)!
        ], for: .normal)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [firstVC, secondVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
