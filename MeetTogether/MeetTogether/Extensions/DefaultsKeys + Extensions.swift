//
//  DefaultsKeys + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var firstLaunch: DefaultsKey<Bool> { .init("firstLaunch", defaultValue: true) }
}

