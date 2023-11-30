//
//  MainModuleCoordinator.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import UIKit

protocol MainModuleCoordinator: Coordinator, AnyObject {
//    func pushMainScreen()
}

final class MainModuleCoordinatorImpl: MainModuleCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = GalleryAllPhotosViewControllerImpl()
        
        navigationController.pushViewController(view, animated: true)
    }
}
