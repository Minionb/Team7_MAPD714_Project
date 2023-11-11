//
//  AppDelegate.swift
//  Team7_MAPD714_Project-Milestone2
//
//  Created by Hilary Ng on 29/10/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create the window
               window = UIWindow(frame: UIScreen.main.bounds)
               
               // Create the initial view controller
               let packageDetailsViewController = PackageDetailsViewController()
               
               // Create the navigation controller and set the initial view controller as the root view controller
               let navigationController = UINavigationController(rootViewController: packageDetailsViewController)
               
               // Set the navigation controller as the root view controller of the window
               window?.rootViewController = navigationController
               
               // Make the window visible
               window?.makeKeyAndVisible()
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

