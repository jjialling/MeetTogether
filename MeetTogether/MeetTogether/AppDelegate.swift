//
//  AppDelegate.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import FirebaseCore
import IQKeyboardManagerSwift
import SwiftyUserDefaults
import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController = MainTabBarViewController()
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        if UserManager.shared.firstLaunch {
            Defaults[\.firstLaunch] = false
        }

        configureGoogleMap()
        configureIQKeyboardManager()
        return true
    }

}
extension AppDelegate {
    private func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

   
    private func configureGoogleMap() {
        GMSServices.provideAPIKey("AIzaSyAKB9YeUckSvQk5fNbtUlKjKotWEk74uFU")
    }
}

