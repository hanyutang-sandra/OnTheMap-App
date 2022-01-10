//
//  LocationViewController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation
import UIKit

class LocationViewController: UIViewController {
    private lazy var logoutBarButtonItem = UIBarButtonItem(title: "LOG OUT", style: .plain, target: self, action: #selector(logout))
    private lazy var refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    private lazy var addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "On the Map"
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        self.navigationItem.rightBarButtonItems = [addBarButtonItem, refreshBarButtonItem]
        
        let navBar = self.navigationController?.navigationBar
        navBar?.backgroundColor = .white
        navBar?.tintColor = UIColor(red: 0.01, green: 0.70, blue: 0.89, alpha: 1.00)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func logout() {
        Requests.logout { success, error in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func refresh() {
        Requests.getStudentLocations { results, error in
            guard let results = results else {
                return
            }
            ResultsModel.results = results
        }
    }
    
    @objc func addLocation() {
        let infoPostingViewController = InfoPostingViewController()
        self.navigationController?.pushViewController(infoPostingViewController, animated: true)
    }
}
