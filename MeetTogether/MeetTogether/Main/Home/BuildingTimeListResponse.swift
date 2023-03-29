//
//  BuildingTimeListResponse.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/29.
//

import Foundation

// MARK: - Welcome
struct BuildingTimeListResponse: Codable {
    let data: [String: BuildingTimeList]
}

// MARK: - Datum
struct BuildingTimeList: Codable {
    let businessHours: [BusinessHour]
    let name: String

    enum CodingKeys: String, CodingKey {
        case businessHours = "business hours"
        case name
    }
}

// MARK: - BusinessHour
struct BusinessHour: Codable {
    let date, time: String
}
