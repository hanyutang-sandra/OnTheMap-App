//
//  NavBarController.swift
//  On the Map
//
//  Created by Hanyu Tang on 2/10/22.
//

import Foundation
import UIKit

class NavBarController: UIViewController {
    private lazy var logoutBarButtonItem = UIBarButtonItem(title: "LOG OUT", style: .plain, target: self, action: #selector(logout))
    private lazy var addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "On the Map"
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        
        let navBar = self.navigationController?.navigationBar
        navBar?.backgroundColor = .white
        navBar?.tintColor = UIColor(red: 0.01, green: 0.70, blue: 0.89, alpha: 1.00)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: Tap Handlers
extension NavBarController {
    @objc func logout() {
        Requests.logout { _, _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func addLocation() {
        let infoPostingViewController = InfoPostingViewController()
        self.navigationController?.pushViewController(infoPostingViewController, animated: true)
    }
}
