//
//  RegistrationViewControllerimpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 25.11.2023.
//

import UIKit

final class RegistrationViewControllerimpl: UIViewController {
    private let check = CheckField.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "name"
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self
        nameTextField.tintColor = .warmPink
        nameTextField.textAlignment = .center
        nameTextField.keyboardType = .default
        nameTextField.textColor = .gray
        nameTextField.layer.cornerRadius = 12
        nameTextField.backgroundColor = .lightYellow
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    private lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "email"
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        emailTextField.tintColor = .warmPink
        emailTextField.textAlignment = .center
        emailTextField.keyboardType = .emailAddress
        emailTextField.textColor = .gray
        emailTextField.layer.cornerRadius = 12
        emailTextField.backgroundColor = .lightYellow
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
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
    
    private lazy var confirmPasswordTextField: UITextField = {
        let confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = "confirm password"
        confirmPasswordTextField.returnKeyType = .go
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.tintColor = .warmPink
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.textAlignment = .center
        confirmPasswordTextField.textColor = .gray
        confirmPasswordTextField.layer.cornerRadius = 12
        confirmPasswordTextField.backgroundColor = .lightYellow
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        return confirmPasswordTextField
    }()
    
    private lazy var registrationButton: UIButton = {
        let registrationButton = UIButton()
        registrationButton.setTitle("Register", for: .normal)
        registrationButton.setTitleColor(.warmPink, for: .normal)
        registrationButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registrationButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
        registrationButton.layer.cornerRadius = 12
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        return registrationButton
    }()
        
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([logoLabel, nameTextField,
                          emailTextField, passwordTextField,
                          confirmPasswordTextField, registrationButton])
   
        
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc
    private func registration() {
       
    }
    
    override func updateViewConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -25),
            
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -25),
            
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.bottomAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: -25),
            
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -40),
            
            registrationButton.heightAnchor.constraint(equalToConstant: 65),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
        super.updateViewConstraints()
    }
}

extension RegistrationViewControllerimpl: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
            case nameTextField:
                check.validField(nameTextField, fieldType: .username)
            case emailTextField:
                check.validField(emailTextField, fieldType: .email)
            case passwordTextField:
                check.validField(passwordTextField, fieldType: .password)
            default:
                check.validField(confirmPasswordTextField, fieldType: .confirmPassword)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            if self.nameTextField.backgroundColor == .softGreen &&
                self.emailTextField.backgroundColor == .softGreen &&
                self.passwordTextField.backgroundColor == .softGreen &&
                self.confirmPasswordTextField.backgroundColor == .softGreen &&
                self.passwordTextField.text == self.confirmPasswordTextField.text {
                self.registrationButton.backgroundColor = .softGreen
            }
            else {
                self.registrationButton.backgroundColor = .clear
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case nameTextField:
                emailTextField.becomeFirstResponder()
            case emailTextField:
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                confirmPasswordTextField.becomeFirstResponder()
            default:
            if passwordTextField.text == confirmPasswordTextField.text {
                print("пароли совпадают")
                registration()
            }
            else {
                print("пароли не совпадают")
            }
        }
        return true
    }
}
