//
//  SceneDelegate.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 09.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: Coordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
    }
}
