//
//  SceneDelegate.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window  = UIWindow(windowScene: windowScene)

        let initialViewController = CharacterRouter.createModule()
        let navigationController = UINavigationController(rootViewController: initialViewController)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
