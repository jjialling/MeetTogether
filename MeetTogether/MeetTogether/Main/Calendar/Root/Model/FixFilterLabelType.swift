//
//  FixFilterLabelType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/5.
//

import UIKit

enum FixFilterLabelType: CaseIterable {
    case all
    case art
    case banquet
    case club
    case wellness
    case meeting
    case workshop

    var title: String {
        switch self {
        case .all:
            return "All"
        case .art:
            return "Art"
        case .banquet:
            return "Banquet"
        case  .club:
            return "Club"
        case .wellness:
            return "Wellness"
        case .meeting:
            return "Meeting"
        case .workshop:
            return "Workshop"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .all:
            return UIColor(hex: "#FFF2E3")
        case .art, .meeting, .banquet:
            return UIColor(hex: "#E3ECFF")
        case .workshop, .wellness, .club:
            return UIColor(hex: "#E1F5E3")
        }
    }

}
