//
//  UserManager.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import Foundation
import SwiftyUserDefaults

enum UserType: String {
    case student = "S"
    case teacher = "T"
}

class UserManager {
    static let shared = UserManager()

    private init() {}

    var userType: UserType = .student

    var firstLaunch: Bool {
        return Defaults[\.firstLaunch]
    }
}

