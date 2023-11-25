//
//  RegistrationViewControllerimpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 25.11.2023.
//

import UIKit

final class RegistrationViewControllerimpl: UIViewController {
    private let check = CheckField.shared
    private var logoLabelY: CGFloat!
    private var textFieldWidht: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoLabelY = 10
        textFieldWidht = view.frame.width - 160
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
                logoLabel.frame.origin.y = logoLabelY + keyboardSize.height
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            logoLabel.frame.origin.y = logoLabelY
            self.view.frame.origin.y = 0
        }
    }
    
    private lazy var logoLabel: UILogoLabel = {
        let logoLabel = UILogoLabel(frame: CGRect(x: 0,
                                                  y: logoLabelY,
                                                  width: view.frame.width,
                                                  height: 200))
        return logoLabel
    }()
    
    private lazy var nameTextField: UITextFieldAuth = {
        let nameTextField = UITextFieldAuth(placeholder: "name",
                                            returnKeyType: .next,
                                            delegate: self,
                                            keyboardType: .default)
        return nameTextField
    }()
    
    private lazy var emailTextField: UITextFieldAuth = {
        let emailTextField = UITextFieldAuth(placeholder: "email",
                                             returnKeyType: .next,
                                             delegate: self,
                                             keyboardType: .emailAddress)
        return emailTextField
    }()
    
    private lazy var passwordTextField: UITextFieldAuth = {
        let passwordTextField = UITextFieldAuth(placeholder: "password",
                                                returnKeyType: .next,
                                                delegate: self, keyboardType: .default)
        return passwordTextField
    }()
    
    private lazy var confirmPasswordTextField: UITextFieldAuth = {
        let passwordTextField = UITextFieldAuth(placeholder: "confirm password",
                                                returnKeyType: .go,
                                                delegate: self, keyboardType: .default)
        return passwordTextField
    }()
    
    private lazy var stackWithTextFields: UIStackView = {
        let stackWithTextFields = UIStackView(arrangedSubviews: [nameTextField,
                                                                 emailTextField,
                                                                 passwordTextField,
                                                                 confirmPasswordTextField])
        stackWithTextFields.contentMode = .left
        stackWithTextFields.axis = .vertical
        stackWithTextFields.spacing = 15
        stackWithTextFields.distribution = .fillEqually
        stackWithTextFields.alignment = .center
        stackWithTextFields.translatesAutoresizingMaskIntoConstraints = false
        return stackWithTextFields
    }()
    
    private lazy var registrationButton: UIButtonAuth = {
        let registrationButton = UIButtonAuth(title: "Register",
                                              action: #selector(registration),
                                              target: self)
        return registrationButton
    }()
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([logoLabel, stackWithTextFields, registrationButton])
   
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc
    private func registration() {
       
    }
    
    override func updateViewConstraints() {
        NSLayoutConstraint.activate([
            stackWithTextFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            stackWithTextFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            stackWithTextFields.heightAnchor.constraint(equalToConstant: 245),
            stackWithTextFields.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -25),
            
            nameTextField.widthAnchor.constraint(equalToConstant: textFieldWidht),
            emailTextField.widthAnchor.constraint(equalToConstant: textFieldWidht),
            passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWidht),
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: textFieldWidht),

            registrationButton.heightAnchor.constraint(equalToConstant: 50),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
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
//            let views = self.stackWithTextFields.arrangedSubviews
//            let succssesed = !views.contains { $0.backgroundColor != .softGreen } &&
//            self.passwordTextField.text == self.confirmPasswordTextField.text
//
//            if succssesed {
//                self.registrationButton.backgroundColor = .softGreen
//            }
//            else {
//                self.registrationButton.backgroundColor = .clear
//            }
            
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
