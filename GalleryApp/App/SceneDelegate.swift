//
//  SceneDelegate.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 09.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        let navController = UINavigationController(rootViewController: GalleryAllPhotosViewControllerImpl())
//        let navController = UINavigationController(rootViewController: RegistrationViewControllerimpl())
        let navController = UINavigationController(rootViewController: LoginViewControllerImpl())
        navController.navigationBar.tintColor = .warmPink
        let viewController = navController
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

