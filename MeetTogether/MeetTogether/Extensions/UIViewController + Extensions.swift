//
//  UIViewController + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import UIKit

extension UIViewController {

    func presentFullScreen(_ viewControllerToPresent: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if presentedViewController == nil { // MARK: - Fix present modally an active controller,
            // MARK: - Remove run in main thread code because of present modally issue
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            present(viewControllerToPresent, animated: animated, completion: completion)
        } else {
            presentedViewController?.dismiss(animated: false) {
                self.presentFullScreen(viewControllerToPresent, animated: true, completion: completion)
            }
        }
    }
    
//    func phoneCall(number: String) {
//        let number = number.filter { !$0.isWhitespace }
//        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
//    }

    func presentBaseNavigation<T: UIViewController>(rootVC: T, modalPresentationStyle: UIModalPresentationStyle = .automatic) {
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = modalPresentationStyle
        present(navVC, animated: true, completion: nil)
    }

    func popToRootTabViewControllerAndSelect(currentTab: TabBarItem, selectedTab: TabBarItem) {
        let tabBar = view.window?.rootViewController as? UITabBarController
        tabBar?.selectedIndex = selectedTab.index
        // pop to root if navigated before
        if let nav = tabBar?.viewControllers?[currentTab.index] as? UINavigationController {
            nav.popToRootViewController(animated: true)
        }
    }
}

