//
//  EventsTargetType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation
import Moya


protocol EventsTargetType: DecodableResponseTargetType {}

extension EventsTargetType {

    var baseURL: URL { URL(string: Network.baseURL)! }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        return Network.apiHeader
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }

}
enum EventsAPI {
    struct EventsList: EventsTargetType {
        typealias Response = EventListResponse

        var path: String { "/events" }

        var task: Task { .requestPlain }

        var method: Moya.Method { .get }
    }
    
    struct EventDetail: EventsTargetType {
        typealias Response = EventDetailResponse

        var path: String { "/events/\(eventDetailID)" }

        var task: Task { .requestPlain }

        var method: Moya.Method { .get }
        
        private var eventDetailID: String
        
        init(eventDetailID: String) {
            self.eventDetailID = eventDetailID
        }
        
    }
}
