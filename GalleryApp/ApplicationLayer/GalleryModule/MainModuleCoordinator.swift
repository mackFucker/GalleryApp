//
//  MainModuleCoordinator.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import UIKit
import FirebaseAuth

protocol MainModuleCoordinator: Coordinator, AnyObject {
    func pushToFullScreen(data: [UIImage],
                          index: Int)
}

final class MainModuleCoordinatorImpl: MainModuleCoordinator {
    
    let navigationController: UINavigationController
    let user: User
    
    init(navigationController: UINavigationController,
         user: User) {
        
        self.navigationController = navigationController
        self.user = user
    }
    
    func pushToFullScreen(data: [UIImage],
                          index: Int) {
        let view = GalleryFullScreenViewControllerImpl(mockDataArray: data,
                                                       index: index)
        
        navigationController.pushViewController(view,
                                                animated: true)
    }
    
    func start() {
        let view = GalleryAllPhotosViewControllerImpl()
        let presenter = GalleryAllPhotosPresenterImpl(view: view,
                                                      user: user,
                                                      service: StorageService.share,
                                                      coordinator: self)
        view.presenter = presenter
        self.navigationController.pushViewController(view,
                                                    animated: true)
    }
} 
