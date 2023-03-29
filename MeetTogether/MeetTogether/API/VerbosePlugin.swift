//
//  VerbosePlugin.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation
import Moya

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let body = request.httpBody {
            if verbose {
                print("JSON Request: \(body.prettyPrintedJSONString ?? ""))")
            }
        }
        return request
    }
}
