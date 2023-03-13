//
//  SceneDelegate.swift
//  DogePay
//
//  Created by Victor Lee on 2023/03/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let rootViewController = RootTabBarViewController()
        window?.rootViewController = rootViewController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()

    }

}

