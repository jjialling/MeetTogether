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

//        configureFirebase()
        configureIQKeyboardManager()
        return true
    }

}
extension AppDelegate {
    private func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

   
    private func configureFirebase() {
        // MARK: Firebase
        var filePath: String?
        #if DEV
            print("[FIREBASE] Development mode.")
            filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        #elseif STAGING
            print("[FIREBASE] Staging mode.")
            filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        #else
            print("[FIREBASE] Production mode.")
            filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        #endif
        guard let fileopts = FirebaseOptions(contentsOfFile: filePath!) else {
            assert(false, "Couldn't load config file")
            return
        }
        FirebaseApp.configure(options: fileopts)
    }
}

