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
        let viewModel = PersonsListViewModel()
        let viewController = PersonsListViewController(viewModel: viewModel)

        let title = "List View"
        let image = UIImage(systemName: "info.circle")
        let selectedImage = UIImage(systemName: "info.circle.fill")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBar.tintColor = UIColor(named: "pink001")
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    lazy private var multiLocationVC: MultiLocationMapViewController = {
        let viewModel = MultiLocationMapViewModel()
        let viewController = MultiLocationMapViewController(viewModel: viewModel)
        let title = "Map View"
        let image = UIImage(systemName: "map")
        let selectedImage = UIImage(systemName: "map.fill")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)

        tabBarItem.title = title
        viewController.title = title
        viewController.navigationItem.title = title
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
