//
//  LoginViewControllerImplViewController.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 23.11.2023.
//

import UIKit

final class LoginViewControllerImpl: UIViewController {
    private let check = CheckField.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                logoLabel.frame.origin.y = view.frame.height / 2 - 400 + keyboardSize.height
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            logoLabel.frame.origin.y = view.frame.height / 2 - 400
            self.view.frame.origin.y = 0
        }
    }
    
    private lazy var logoLabel: UIView = {
        let loginButton = UIView(frame: CGRect(x: 0,
                                               y: view.frame.height / 2 - 400,
                                               width: view.frame.width,
                                               height: 200))
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.warmPink.cgColor, UIColor.softOrange.cgColor]
        
        gradient.startPoint = CGPoint(x: 0.3, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.6, y: 0.5)
        
        gradient.frame = loginButton.bounds
        loginButton.layer.addSublayer(gradient)
        logoLabelMask.frame = loginButton.frame
        loginButton.mask = logoLabelMask
        return loginButton
    }()
    
    private lazy var logoLabelMask: UILabel = {
        let logoLabel = UILabel()
        logoLabel.font = UIFont(name: "Token", size: 60)
        logoLabel.text = "GuardDisk"
        logoLabel.textAlignment = .center
        return logoLabel
    }()
    
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.placeholder = "login"
        loginTextField.returnKeyType = .next
        loginTextField.delegate = self
        loginTextField.tintColor = .warmPink
        loginTextField.textAlignment = .center
        loginTextField.keyboardType = .emailAddress
        loginTextField.textColor = .gray
        loginTextField.layer.cornerRadius = 12
        loginTextField.backgroundColor = .lightYellow
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "password"
        passwordTextField.returnKeyType = .go
        passwordTextField.delegate = self
        passwordTextField.tintColor = .warmPink
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .center
        passwordTextField.textColor = .gray
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.backgroundColor = .lightYellow
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.warmPink, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.layer.cornerRadius = 10
        return loginButton
    }()
    
    private lazy var registrationButton: UIButton = {
        let registrationButton = UIButton()
        registrationButton.setTitle("Register", for: .normal)
        registrationButton.setTitleColor(.warmPink, for: .normal)
        registrationButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registrationButton.addTarget(self, action: #selector(openRegistration), for: .touchUpInside)
        registrationButton.layer.cornerRadius = 10
        return registrationButton
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [registrationButton, loginButton])
        stack.axis = .horizontal
        stack.spacing = 25
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(logoLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(stack)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc
    private func login() {
        navigationController?.pushViewController(GalleryAllPhotosViewControllerImpl(),
                                                 animated: true)
//        if  check.validField(loginTextField, fieldType: .login),
//            check.validField(passwordTextField, fieldType: .password) {
//            if loginTextField.text == "devid200590@gmail.com"
//                && passwordTextField.text == "1111111" {
//                navigationController?.pushViewController(GalleryAllPhotosViewControllerImpl(),
//                                                         animated: true)
//            }
//            else {
//                print("error")
//            }
//        }
    }
    
    @objc
    private func openRegistration() {
        print("open regi...")
    }
    
    override func updateViewConstraints() {
        NSLayoutConstraint.activate([
//            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            passwordTextField.heightAnchor.constraint(equalToConstant: 100),
            
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -25),
            
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -40),
            
            stack.heightAnchor.constraint(equalToConstant: 65),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        super.updateViewConstraints()
    }
}

extension LoginViewControllerImpl: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == loginTextField {
            check.validField(loginTextField, fieldType: .login)
        }
        else {
            check.validField(passwordTextField, fieldType: .password)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            if self.loginTextField.backgroundColor == .softGreen
                && self.passwordTextField.backgroundColor == .softGreen {
                self.loginButton.backgroundColor = .softGreen
            }
            else {
                self.loginButton.backgroundColor = .clear
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            login()
        }
        return true
    }
}
