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
extension UIViewController {
    
    func setLargeTitleStyle(title: String?,
                            textColor: UIColor = UIColor.white,
                            backgroundColor: UIColor = UIColor.white,
                            hideNavigationBarShadow: Bool = true) {
        navigationItem.title = title

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false

        let largeAttributes: [NSAttributedString.Key: Any] = [.font: FontBook.font(.bold, fontSize: .size(28)),
                                                              .foregroundColor: textColor]

        let style = UINavigationBarAppearance()
        style.configureWithDefaultBackground()
        style.backgroundColor = backgroundColor
        style.largeTitleTextAttributes = largeAttributes
        if hideNavigationBarShadow {
            style.shadowColor = nil
        }

        navigationController?.navigationBar.standardAppearance = style
        navigationController?.navigationBar.compactAppearance = style
        navigationController?.navigationBar.scrollEdgeAppearance = style
        navigationController?.navigationBar.largeTitleTextAttributes = largeAttributes
    }
    
    func setNavBackStyle(color: UIColor = .Neutral.whiteStroke) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.backgroundColor = color
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.setImage(UIImage(named: "icon_nav_arrow_left"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        let backBarItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backBarItem
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavCloseButton(onLeft: Bool = true, action: Selector = #selector(leaveViewController)) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.backgroundColor = .Neutral.whiteStroke
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.setImage(UIImage(named: "icon_close"), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        let closeBarItem = UIBarButtonItem(customView: button)

        if onLeft {
            navigationItem.leftBarButtonItem = closeBarItem
        } else {
            navigationItem.rightBarButtonItem = closeBarItem
        }
        navigationController?.navigationBar.tintColor = .black
    }

    @objc private func leaveViewController() {
        leaveViewController(completion: nil)
    }
    
    @objc func leaveViewController(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        if let viewcontrollers = navigationController?.viewControllers, viewcontrollers.count > 1 {
            if viewcontrollers[viewcontrollers.count - 1] == self {
                navigationController?.setNavigationBarHidden(false, animated: false)
                _ = navigationController?.popViewController(animated: true)
                completion?()
            }
        } else {
            dismiss(animated: animated, completion: completion)
        }
    }
    
    func setNavTransparentStyle() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}
