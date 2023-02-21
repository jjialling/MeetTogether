//
//  TabBarItemType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import Foundation
import UIKit

protocol TabBarItem {
    var index: Int { get }
    var title: String { get }
    var image: UIImage? { get }
    var selectedImage: UIImage? { get }
}

enum StudentTabBarItemType: Int, TabBarItem {
    case home = 0
    case calendar
    case student
    case profile

    var index: Int {
        return rawValue
    }

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .calendar:
            return "Official"
        case .student:
            return "Student"
        case .profile:
            return "Profile"
        }
    }

    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icon_home_selected")
        case .calendar:
            return UIImage(named: "icon_official")
        case .student:
            return UIImage(named: "icon_student_selected")
        case .profile:
            return UIImage(named: "icon_profile")
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icon_home_selected")
        case .calendar:
            return UIImage(named: "icon_stock_selected")
        case .student:
            return UIImage(named: "icon_student_selected")
        case .profile:
            return UIImage(named: "icon_customer_selected")
        }
    }
}

