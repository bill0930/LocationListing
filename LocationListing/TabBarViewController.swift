//
//  TabBarViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit
import Moya

final class TabBarController: UITabBarController {

    lazy private var firstVC: PersonsListViewController = {
        let apiService = APIService()
        let viewModel = PersonsListViewModel(apiService: apiService)
        let viewController = PersonsListViewController(viewModel: viewModel)
        let title = "List View"
        let image = UIImage(systemName: "info.circle")
        let selectedImage = UIImage(systemName: "info.circle.fill")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBar.tintColor = UIColor(named: "pink005")
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    lazy private var secondVC: MultiLocationMapViewController = {
        let viewController = MultiLocationMapViewController()
        let title = "Map View"
        let image = UIImage(systemName: "map")
        let selectedImage = UIImage(systemName: "map.fill")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBar.tintColor = UIColor(named: "pink005")
        tabBarItem.title = title
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [firstVC, secondVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
