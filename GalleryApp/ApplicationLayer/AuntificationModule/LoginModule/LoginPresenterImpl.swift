//
//  LoginViewPresenterImpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import Foundation

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
        service.signIn(data) { result in
            switch result {
                case .success(let user):
                    self.coordinator.pushMainScreen(user: user)
                    print("success login")
                case .error(let error):
                    print(error)
                case .noVerify:
                    print("No verify firebase")
            }
        }
    }
    
    func registrateOpen() {
        coordinator.registrationOpen()
    }
}
