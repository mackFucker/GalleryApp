//
//  AuthCoordinator.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import UIKit

protocol AuthCoordinator: Coordinator, AnyObject {
    func pushMainScreen()
}

final class AuthModuleCoordinator: AuthCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registrationView = RegistrationViewControllerImpl()
        let presenter = RegistrationPresenterImpl(view: registrationView,
                                                  service: AuthService.shared,
                                                  coordinator: self)
        registrationView.presenter = presenter
        
        navigationController.pushViewController(registrationView, animated: true)
    }
    
    func pushMainScreen() {
        let coordinator = MainModuleCoordinatorImpl(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
