//
//  RegistrationPresenterImpl.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import Foundation

protocol RegistrationPresenter: AnyObject {
//    var view: RegistrationViewController? { get set }
    var service: AuthService { get set }
    func signup(data: RegistrationField)
}

final class RegistrationPresenterImpl: RegistrationPresenter {
    var service = AuthService.shared
    weak var view: RegistrationViewController!
    
    init(view: RegistrationViewController) {
        self.view = view
    }
    func signup(data: RegistrationField) {
        service.signup(data) { result in
            
            switch result {
                case .success:
                    print("success")
                case .error(let error):
                    print(error)
            }
        }
    }
}
