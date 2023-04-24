//
//  EventListResponse.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation

struct EventListResponse: Codable {
    let data: [String: EventList]
}

struct EventList: Codable {
    let contactEmail, contactName, contactPhone, content: String
    let cost, date: String
    let image: String
    let organization, title, type, venue: String
}

