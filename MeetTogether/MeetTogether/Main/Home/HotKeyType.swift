//
//  HotKeyType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit

enum HotKeyType: Int, CaseIterable {
    case clubs
    case buildingTime
    case campusMap

    var image: UIImage? {
        switch self {
        case .clubs:
            return UIImage(named: "icon_club")
        case .buildingTime:
            return UIImage(named: "icon_time")
        case .campusMap:
            return UIImage(named: "icon_map")
        }
    }

    var title: String {
        switch self {
        case .clubs:
            return "Clubs"
        case .buildingTime:
            return "Building Times"
        case .campusMap:
            return "Campus Map"
        }
    }
}

