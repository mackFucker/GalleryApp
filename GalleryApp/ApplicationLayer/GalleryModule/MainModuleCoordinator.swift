//
//  MainModuleCoordinator.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import UIKit
import FirebaseAuth

protocol MainModuleCoordinator: Coordinator, AnyObject {
//    func pushMainScreen()
}

final class MainModuleCoordinatorImpl: MainModuleCoordinator {
    
    let navigationController: UINavigationController
    let user: User
    
    init(navigationController: UINavigationController,
         user: User) {
        
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let view = GalleryAllPhotosViewControllerImpl()
        let presenter = GalleryAllPhotosPresenterImpl(view: view,
                                                      user: user)
        view.presenter = presenter
        navigationController.pushViewController(view,
                                                animated: true)
    }
} 
