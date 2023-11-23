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
        //        let layer = CustomGradientLayerBackgroundAuth(view: view)
        //        view.layer.addSublayer(layer)
        addNotification()
        setupUI()
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
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
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
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(stack)
    }
    
    @objc
    private func login() {
        if  check.validField(loginTextField),
            check.validField(passwordTextField) {
            if passwordTextField.text == "111" && loginTextField.text == "111"{
                navigationController?.pushViewController(GalleryAllPhotosViewControllerImpl(),
                                                         animated: true)
            }
            else{
                print("error")
            }
        }        
    }
    
    @objc
    private func openRegistration() {
        print("open regi...")
    }
    
    override func updateViewConstraints() {
        NSLayoutConstraint.activate([
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
        
        switch textField {
        case loginTextField:
            check.validField(loginTextField)
        default:
            check.validField(passwordTextField)
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
