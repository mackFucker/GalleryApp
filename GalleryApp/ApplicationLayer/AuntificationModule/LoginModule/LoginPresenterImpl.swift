//
//  LoginViewPresenterImpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import Foundation

protocol LoginPresenter: AnyObject {
    func signin(data: RegistrationField)
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
    
    func signin(data: RegistrationField) {
        service.signin(data) { result in
            switch result {
                case .success:
                    self.coordinator.pushMainScreen()
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
