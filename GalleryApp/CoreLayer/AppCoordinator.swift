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
        let navController = UINavigationController()
        navController.navigationBar.tintColor = .warmPink
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        let coordinator = AuthModuleCoordinator(navigationController: navController)
        coordinate(to: coordinator)
    }
}


