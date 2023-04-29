//
//  EventDetailResponse.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/4/24.
//

import Foundation

struct EventDetailResponse: Codable {
    let documentID: String
    let data: EventDetail

    enum CodingKeys: String, CodingKey {
        case documentID = "documentId"
        case data
    }
}

struct EventDetail: Codable {
    let contactEmail, contactName, contactPhone, content: String
    let cost, date, image, organization: String
    let title, type, venue: String
}
