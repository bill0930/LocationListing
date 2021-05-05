//
//  TabBarViewController.swift
//  LocationListing
//
//  Created by Billy Chan on 5/5/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy private var firstVC: LocationListViewController = {
        let viewController = LocationListViewController()
        let title = "List View"
        let tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    lazy private var secondVC: MultiLocationMapViewController = {
        let viewController = MultiLocationMapViewController()
        let title = "Map View"
        let tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}
