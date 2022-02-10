//
//  LocationTabbedTableViewController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation
import UIKit

class LocationTabbedTableViewController: NavBarController {
    private let tabbedTableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabbedTableView)
        view.addSubview(activityIndicator)
        view.backgroundColor = .white
        installConstraints()
        
        tabbedTableView.delegate = self
        tabbedTableView.dataSource = self
        tabbedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationDataCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func installConstraints() {
        tabbedTableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tabbedTableView.contentMode = .scaleAspectFit
        tabbedTableView.rowHeight = 50
        
        NSLayoutConstraint.activate([
            tabbedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabbedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabbedTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tabbedTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

// MARK: UITableView
extension LocationTabbedTableViewController: UITableViewDelegate, UITableViewDataSource {
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
        let media = ResultsModel.results[indexPath.row].mediaURL
        if let url = URL(string: media) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func loadData() {
        self.handleLoading(isLoading: true)
        Requests.getStudentLocations { locationResults, error in
            guard let locationResults = locationResults else {
                self.handleLoading(isLoading: false)
                self.showAlert(title: "Oops! Something is wrong", message: error?.errorDescription ?? AppError.unknowError.errorDescription ?? "")
                return
            }
            ResultsModel.results = locationResults
            self.tabbedTableView.reloadData()
            self.handleLoading(isLoading: false)
        }
    }
}

// MARK: Alert
extension LocationTabbedTableViewController {
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func handleLoading(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
