//
//  EventListResponse.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation

// MARK: - Welcome
struct EventListResponse: Codable {
    let data: [String: EventList]
}

// MARK: - Datum
struct EventList: Codable {
    let contactEmail, contactName, contactPhone, content: String
    let cost, date, organization, title: String
    let type, venue: String
}

