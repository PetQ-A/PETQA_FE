//
//  SceneDelegate_apple_login.swift
//  PetQnA
//
//  Created by 김가영 on 7/15/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        //rootViewController 설정
        window?.rootViewController = MyViewController()
        window?.makeKeyAndVisible()
    }
 
}

