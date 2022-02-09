//
//  TabbedTableViewController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation
import UIKit

class TabbedTableViewController: LocationViewController {
    private let tabbedTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabbedTableView)
        view.backgroundColor = .white
        installConstraints()
        
        tabbedTableView.delegate = self
        tabbedTableView.dataSource = self
        tabbedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationDataCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabbedTableView.reloadData()
    }
    
    func installConstraints() {
        tabbedTableView.translatesAutoresizingMaskIntoConstraints = false
        tabbedTableView.contentMode = .scaleAspectFit
        tabbedTableView.rowHeight = 50
        
        NSLayoutConstraint.activate([
            tabbedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabbedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabbedTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tabbedTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension TabbedTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultsModel.results.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "locationDataCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "locationDataCell")
        cell.imageView?.image = UIImage(named: "icon_pin")
        cell.textLabel?.text = ResultsModel.results[indexPath.row].firstName + " " + ResultsModel.results[indexPath.row].lastName
        cell.detailTextLabel?.text = ResultsModel.results[indexPath.row].mediaURL
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = ResultsModel.results[indexPath.row].mediaURL
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
}
