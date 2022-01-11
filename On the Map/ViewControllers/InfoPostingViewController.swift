//
//  InfoPostingViewController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/5/22.
//

import Foundation
import UIKit
import MapKit

class InfoPostingViewController: UIViewController {
    
    private let logoImageView = UIImageView(image: UIImage(named: "icon_world"))
    
    private let infoPostingStackView = UIStackView()
    private let locationTextField = UITextField()
    private let mediaURLTextField = UITextField()
    private let findLocationButton = UIButton(type: .roundedRect)
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Add Location"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleGoBack))
        
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(infoPostingStackView)
        view.addSubview(activityIndicator)
        handleLoading(isLoading: false)
        installConstraints()
    }
    
    func installConstraints() {
        configure()
        
        let views = [logoImageView, infoPostingStackView]
        var layoutConstraints:[NSLayoutConstraint] = []
        
        for _view in views {
            _view.translatesAutoresizingMaskIntoConstraints = false
            layoutConstraints.append(
                _view.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            )
        }
        
        for view in infoPostingStackView.subviews {
            layoutConstraints.append(view.heightAnchor.constraint(equalToConstant: 50))
        }
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -200),
            infoPostingStackView.centerYAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            infoPostingStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -100)
        ] + layoutConstraints)
    }
    
    func configure() {
        infoPostingStackView.addArrangedSubview(locationTextField)
        infoPostingStackView.addArrangedSubview(mediaURLTextField)
        infoPostingStackView.addArrangedSubview(findLocationButton)
        infoPostingStackView.axis = .vertical
        infoPostingStackView.spacing = 10
        
        locationTextField.placeholder = "Location"
        locationTextField.borderStyle = .roundedRect
        
        mediaURLTextField.placeholder = "Media URL"
        mediaURLTextField.borderStyle = .roundedRect
        mediaURLTextField.autocorrectionType = .no
        
        let UdaColor = UIColor(red: 0.01, green: 0.70, blue: 0.89, alpha: 1.00)
        findLocationButton.setTitle("FIND LOCATION", for: .normal)
        findLocationButton.backgroundColor = UdaColor
        findLocationButton.layer.cornerRadius = 5
        findLocationButton.addTarget(self, action: #selector(handleFindLocationTapped), for: .touchUpInside)
        
        activityIndicator.hidesWhenStopped = true
    }
}

extension InfoPostingViewController {
    @objc func handleFindLocationTapped() {
        handleLoading(isLoading: true)
        StudentLocationModel.mediaURL = self.mediaURLTextField.text ?? ""
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(self.locationTextField.text ?? "") { placemark, error in
            guard let placemark = placemark else {
                return
            }
            StudentLocationModel.mapString = placemark[0].name ?? ""
            StudentLocationModel.longitude = placemark[0].location?.coordinate.longitude ?? 0.0
            StudentLocationModel.latitude = placemark[0].location?.coordinate.latitude ?? 0.0
        }
        
        Requests.getStudentInfo { studentInfo, error in
            guard let studentInfo = studentInfo else {
                return
            }
            StudentLocationModel.firstName = studentInfo.firstName
            StudentLocationModel.lastName = studentInfo.lastName
            StudentLocationModel.uniqueKey = studentInfo.key
            
            Requests.postStudentLocation { success, error in
                if success {
                    let pinLocationViewController = PinLocationViewController()
                    self.navigationController?.pushViewController(pinLocationViewController, animated: true)
                } else {
                    self.handleLoading(isLoading: false)
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    @objc func handleGoBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func handleLoading(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        locationTextField.isEnabled = !isLoading
        mediaURLTextField.isEnabled = !isLoading
        findLocationButton.isEnabled = !isLoading
    }
}
