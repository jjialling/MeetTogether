//
//  MainTabBarViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import UIKit
import SwiftyUserDefaults

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()

        switch UserManager.shared.userType {
        case .student:
            configureStudentVC()
        case .teacher:
            configureStudentVC() 
        }
    }
    
}
extension MainTabBarViewController {
    private func configureStudentVC() {
        let homeVC = HomeViewController()
        let homeNav = templateNavController(type: StudentTabBarItemType.home,
                                            rootViewController: homeVC)

        let calendarVC = CalendarViewController()
        let calendarNav = templateNavController(type: StudentTabBarItemType.calendar,
                                             rootViewController: calendarVC)

        let profileVC = ProfileViewController()
        let profileNav = templateNavController(type: StudentTabBarItemType.profile,
                                                rootViewController: profileVC)

        
        viewControllers = [homeNav, calendarNav, profileNav]
    }
    
    private func templateNavController(type: TabBarItem, rootViewController: UIViewController) -> UINavigationController {

        let nav = UINavigationController(rootViewController: rootViewController)
        
        if let image = type.image {
            nav.tabBarItem.image = image
        }

        if let selectImage = type.selectedImage {
            nav.tabBarItem.selectedImage = selectImage
        }

        nav.tabBarItem.title = type.title

        return nav
    }
    
    private func configureTabBar() {
        tabBar.tintColor = UIColor(hex: "#191919")
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        tabBar.drawShadow()

        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.backgroundColor = .white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }

}
