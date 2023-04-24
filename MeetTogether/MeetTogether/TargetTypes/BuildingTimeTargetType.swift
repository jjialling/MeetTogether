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

    var baseURL: URL { URL(string: Network.baseURL)! }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        return Network.apiHeader
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }

}
enum BuildingTimeAPI {
    struct BuildingTimeList: BuildingTimeTargetType {
        typealias Response = BuildingTimeListResponse

        var path: String { "/buildingTime" }
        
        var parameters: [String: String] { ["page-size": "20"] }

        var task: Task { .requestParameters(parameters: parameters, encoding: URLEncoding.queryString) }

        var method: Moya.Method { .get }
    }
}
