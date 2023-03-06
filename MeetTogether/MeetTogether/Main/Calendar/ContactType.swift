//
//  ContactType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/4.
//

import UIKit

enum ContactType: CaseIterable {
    case venue
    case type
    case organization
    case contactName
    case contactEmail
    case contactPhone
    case cost

    var title: String {
        switch self {
        case .venue:
            return "Venue"
        case .type:
            return "Type of Event"
        case .organization:
            return "Organization Name"
        case .contactName:
            return "Contact Name"
        case .contactEmail:
            return "Contact Email"
        case .contactPhone:
            return "Contact Phone"
        case .cost:
            return "Cost of Event"
        }
    }

}

