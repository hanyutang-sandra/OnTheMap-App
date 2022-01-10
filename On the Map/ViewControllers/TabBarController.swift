//
//  TabBarController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/6/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private let mapViewController = UINavigationController(rootViewController: MapViewController())
    private let mapViewControllerIcon = UITabBarItem(title: "Map View", image: UIImage(named: "icon_mapview-deselected"), tag: 0)
    private let tabbedTableViewController = UINavigationController(rootViewController: TabbedTableViewController())
    private let tabbedTableViewControllerIcon = UITabBarItem(title: "Table View", image: UIImage(named: "icon_listview-deselected"), tag: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = UIColor(red: 0.01, green: 0.70, blue: 0.89, alpha: 1.00)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers = setUpViewControllerItems()
    }
    
    func setUpViewControllerItems() -> [UIViewController] {
        mapViewControllerIcon.selectedImage = UIImage(named: "icon_mapview-selected")
        mapViewController.tabBarItem = mapViewControllerIcon
        tabbedTableViewControllerIcon.selectedImage = UIImage(named: "icon_listview-selected")
        tabbedTableViewController.tabBarItem = tabbedTableViewControllerIcon
        return [mapViewController, tabbedTableViewController]
    }
}
