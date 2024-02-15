//
//  LoginViewPresenterImpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import Foundation
import FirebaseAuth

protocol LoginPresenter: AnyObject {
    func signIn(data: RegistrationField)
    func registrateOpen()
}

final class LoginPresenterImpl: LoginPresenter {
    
    private let service: AuthService
    private let coordinator: AuthCoordinator
    private weak var view: LoginViewController?
    
    init(view: LoginViewController,
         service: AuthService,
         coordinator: AuthCoordinator) {
        
        self.view = view
        self.service = service
        self.coordinator = coordinator
    }
    
    func signIn(data: RegistrationField) {
        Task {
            do {
                let user = try await service.signIn(data)
                Task.detached { @MainActor in
                    self.coordinator.pushMainScreen(user: user)
                }
            }
            catch {
                if let errCode = AuthErrorCode.Code(rawValue: error._code) {
                    switch errCode {
                    case .wrongPassword:
                        self.view?.showAlert(title: "Error",
                                             error: "Wrong password.")
                    case .unverifiedEmail:
                        self.view?.showAlert(title: "Error",
                                             error: "Unverified email")
                        
                    case .invalidEmail:
                        self.view?.showAlert(title: "Error",
                                             error: "Invalid email.")
                    case .networkError:
                        self.view?.showAlert(title: "Error",
                                             error: "Netwotk error.")
                        
                    default:
                        self.view?.showAlert(title: "Error",
                                             error: "Unknown error")
                    }
                }
            }
        }
    }
    
    func registrateOpen() {
        coordinator.registrationOpen()
    }
}
