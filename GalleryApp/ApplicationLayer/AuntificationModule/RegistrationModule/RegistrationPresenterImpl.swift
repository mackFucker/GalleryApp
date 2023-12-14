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
    private weak var view: RegistrationViewController?
    private let coordinator: AuthCoordinator

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
                    self.coordinator.pushMainScreen()
                    print("success registration, u need to confirm email")
                case .error(let error):
                    print(error)
                case .noVerify:
                    print("No verify firebase")
            }
        }
    }
}
