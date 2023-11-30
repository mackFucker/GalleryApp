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
    
    init(view: RegistrationViewController,
         service: AuthService) {
        self.view = view
        self.service = service
    }
    
    func signup(data: RegistrationField) {
        service.signup(data) { result in
            switch result {
                case .success:
                //view.navigate.... or updateViews...
                    print("success")
                case .error(let error):
                    print(error)
            }
        }
    }
}
