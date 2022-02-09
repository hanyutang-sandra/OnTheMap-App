//
//  LoginViewController.swift
//  On the Map
//
//  Created by Hanyu Tang on 1/4/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let logoImageView = UIImageView(image: UIImage(named: "logo-u"))
    
    private let loginStackView = UIStackView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .roundedRect)
    
    private let signupStackView = UIStackView()
    private let signupLabel = UILabel()
    private let signupLink = UIButton(type: .system)
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(loginStackView)
        view.addSubview(signupStackView)
        view.addSubview(activityIndicator)
        handleLoading(isLoading: false)
        installConstraints()
    }
    
    func installConstraints() {
        configure()
        
        let views = [logoImageView, loginStackView, signupStackView, activityIndicator]
        var layoutConstraints:[NSLayoutConstraint] = []
        
        for _view in views {
            _view.translatesAutoresizingMaskIntoConstraints = false
            layoutConstraints.append(
                _view.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            )
        }
        
        for view in loginStackView.subviews {
            layoutConstraints.append(view.heightAnchor.constraint(equalToConstant: 50))
        }
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -200),
            loginStackView.centerYAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            loginStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -100),
            signupStackView.centerYAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 40),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ] + layoutConstraints)
    }
    
    func configure() {
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)
        loginStackView.axis = .vertical
        loginStackView.spacing = 10
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        let UdaColor = UIColor(red: 0.01, green: 0.70, blue: 0.89, alpha: 1.00)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = UdaColor
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(handleLoginTapped), for: .touchUpInside)
        
        signupStackView.addArrangedSubview(signupLabel)
        signupStackView.addArrangedSubview(signupLink)
        
        signupLabel.text = "Don't have an account?"
        signupLink.setTitle("Signup", for: .normal)
        signupLink.setTitleColor(UdaColor, for: .normal)
        signupLink.addTarget(self, action: #selector(handleSignupTapped), for: .touchUpInside)
        
        signupStackView.spacing = 5
        
        activityIndicator.hidesWhenStopped = true
        
    }
}

extension LoginViewController {
    @objc func handleLoginTapped() {
        handleLoading(isLoading: true)
        Requests.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { success, error in
            if success {
                let tabBarController = TabBarController()
                tabBarController.modalPresentationStyle = .fullScreen
                tabBarController.modalTransitionStyle = .flipHorizontal
                self.show(tabBarController, sender: nil)
                self.handleLoading(isLoading: false)
            } else {
                self.handleLoading(isLoading: false)
                self.showAlert(title: "Oops", message: error?.errorDescription ?? AppError.unknowError.errorDescription ?? "")
            }
        }
    }
    
    @objc func handleSignupTapped() {
        handleLoading(isLoading: true)
        UIApplication.shared.open(EndPoints.websiteLogin.url, options: [:], completionHandler: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func handleLoading(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !isLoading
        passwordTextField.isEnabled = !isLoading
        loginButton.isEnabled = !isLoading
    }
}
