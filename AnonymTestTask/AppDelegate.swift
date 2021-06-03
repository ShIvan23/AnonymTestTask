//
//  AppDelegate.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: FeedListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

