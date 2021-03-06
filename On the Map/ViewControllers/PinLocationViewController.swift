//
//  PinLocationViewController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/9/22.
//

import Foundation
import UIKit
import MapKit

class PinLocationViewController: UIViewController {
    private let mapView = MKMapView()
    private let updateLocationButton = UIButton(type: .roundedRect)
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Add Location"
        self.tabBarController?.tabBar.isHidden = true
        
        view.addSubview(mapView)
        view.addSubview(updateLocationButton)
        view.addSubview(activityIndicator)
        installConstraints()
        handleMapPinProcessing()
        handleLoading(isLoading: false)
        
        mapView.delegate = self
    }
    
    func installConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        updateLocationButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        configure()
        
        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            updateLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            updateLocationButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -100),
            updateLocationButton.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configure() {
        let UdaColor = UIColor(red: 0.01, green: 0.70, blue: 0.89, alpha: 1.00)
        updateLocationButton.setTitle("FINISH", for: .normal)
        updateLocationButton.backgroundColor = UdaColor
        updateLocationButton.layer.cornerRadius = 5
        updateLocationButton.addTarget(self, action: #selector(handleFinishTapped), for: .touchUpInside)
        
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: MKMap View
extension PinLocationViewController: MKMapViewDelegate {
    func handleMapPinProcessing() {
        let studentLocation = StudentLocationModel.self
        var annotations = [MKPointAnnotation]()
        let lat = CLLocationDegrees(studentLocation.latitude)
        let long = CLLocationDegrees(studentLocation.longitude)
            
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
        let first = studentLocation.firstName as String
        let last = studentLocation.lastName as String
        let mediaURL = studentLocation.mediaURL as String
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
            
        annotations.append(annotation)
        
        self.mapView.addAnnotations(annotations)
        self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan()), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let subtitleContent = view.annotation?.subtitle ?? nil, let url = URL(string: subtitleContent) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

// MARK: Tap handler
extension PinLocationViewController {
    @objc func handleFinishTapped() {
        handleLoading(isLoading: true)
        Requests.updateStudentLocation { success, error in
            if success {
                self.handleLoading(isLoading: false)
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            } else {
                self.handleLoading(isLoading: false)
                self.showAlert(title: "Oops! Something is wrong", message: error?.errorDescription ?? AppError.unknowError.errorDescription ?? "")
                return
            }
        }
    }
}

// MARK: Alert & ActivityIndicator
extension PinLocationViewController {
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
        updateLocationButton.isEnabled = !isLoading
    }
}


