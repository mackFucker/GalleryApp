//
//  AppCoordinator.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let view = LoginViewControllerImpl()
        
        let navController = UINavigationController(rootViewController: view)
        navController.navigationBar.tintColor = .warmPink
        
        let presenter = LoginPresenterImpl(view: view,
                                           service: AuthService.shared,
                                           coordinator: AuthModuleCoordinator(navigationController: navController) as AuthCoordinator)
        view.presenter = presenter
        
       
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
