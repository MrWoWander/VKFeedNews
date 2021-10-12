//
//  AppDelegate.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 11.10.2021.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print("AppDelegate")
        self.authService = AuthService()
        self.authService.delegate = self
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
            return true
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: AuthServiceDelegate
extension AppDelegate: AuthServiceDelegate {
    func authServiceSholdShow(_ viewController: UIViewController) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first(where: { scene in
            return (scene.delegate as? SceneDelegate) != nil
        })?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController?.present(viewController, animated: true, completion: nil)
        }
    }
    
    func authServiceSingUp() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first(where: { scene in
            return (scene.delegate as? SceneDelegate) != nil
        })?.delegate as? SceneDelegate {
            let storyboard = UIStoryboard(name: "FeedStoryboard", bundle: nil)
            guard let feedVC = storyboard.instantiateInitialViewController() as? FeedViewController else { return }
            let navVC = UINavigationController(rootViewController: feedVC)
            sceneDelegate.window?.rootViewController = navVC
        }
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }
    
    
}
