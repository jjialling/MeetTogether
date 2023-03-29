//
//  BuildingTimeTargetType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/29.
//

import Foundation
import Moya


protocol BuildingTimeTargetType: DecodableResponseTargetType {}

extension BuildingTimeTargetType {

    var baseURL: URL { URL(string: Network.baseBuildingURL)! }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        return Network.apiBuildingHeader
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }

}
enum BuildingTimeAPI {
    struct BuildingTimeList: BuildingTimeTargetType {
        typealias Response = BuildingTimeListResponse

        var path: String { "/time" }

        var task: Task { .requestPlain }

        var method: Moya.Method { .get }
    }
}
