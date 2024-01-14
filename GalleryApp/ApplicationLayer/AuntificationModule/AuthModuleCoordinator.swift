//
//  AuthCoordinator.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import UIKit
import FirebaseAuth

protocol AuthCoordinator: Coordinator, AnyObject {
    func pushMainScreen(user: User)
    func registrationOpen()
}

final class AuthModuleCoordinator: AuthCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = LoginViewControllerImpl()
        let presenter = LoginPresenterImpl(view: view,
                                           service: AuthService.shared,
                                           coordinator: AuthModuleCoordinator(navigationController: navigationController))
        view.presenter = presenter
        navigationController.pushViewController(view,
                                                animated: false)
    }
    
    func registrationOpen() {
        let registrationView = RegistrationViewControllerImpl()
        let presenter = RegistrationPresenterImpl(view: registrationView,
                                                        service: AuthService.shared,
                                                        coordinator: self)
        registrationView.presenter = presenter
        navigationController.pushViewController(registrationView, animated: true)
    }
    
    func pushMainScreen(user: User) {
        let coordinator = MainModuleCoordinatorImpl(navigationController: navigationController,
                                                    user: user)
        coordinate(to: coordinator)
    }
}
