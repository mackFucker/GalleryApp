//
//  RegistrationPresenterImpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import Foundation

protocol RegistrationPresenter: AnyObject {
    func signup(data: RegistrationField)
}

final class RegistrationPresenterImpl: RegistrationPresenter {
    private let service: AuthService
    private let coordinator: AuthCoordinator
    private weak var view: RegistrationViewController?

    init(view: RegistrationViewController,
         service: AuthService,
         coordinator: AuthCoordinator) {
        self.view = view
        self.service = service
        self.coordinator = coordinator
    }
    
    func signup(data: RegistrationField) {
        service.signUp(data) { result in
            switch result {
                case .success(let user):
                self.view?.showAlert(title: "Success registration",
                                     error: "U need to confirm email, and sign in")
                case .error(let error):
                    switch error {
                        case .emailAlreadyInUse:
                            self.view?.showAlert(title: "Error",
                                                 error: "Email already in use.")
                        case .invalidEmail:
                            self.view?.showAlert(title: "Error",
                                                 error: "Invalid email.")
                        case .networkError:
                            self.view?.showAlert(title: "Error",
                                                 error: "Netwotk error.")
                        case .credentialAlreadyInUse:
                            self.view?.showAlert(title: "Error",
                                                 error: "Credential already in use.")
                        case .weakPassword:
                            self.view?.showAlert(title: "Error",
                                                 error: "Weak password.")
                        case .missingEmail:
                            self.view?.showAlert(title: "Error",
                                                 error: "Missing email.")
                        default:
                            self.view?.showAlert(title: "Error",
                                                 error: "Unknown error")
                    }
            }
        }
    }
}
