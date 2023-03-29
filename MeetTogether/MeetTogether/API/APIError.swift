//
//  APIError.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation
import Moya

enum APIError: Error {
    case moyaError(MoyaError)
    case decodeFailed(Error)
    case responseHasNoData(status: Int, message: String)
}

extension APIError {

    /// Server回傳的 statusCode
    var status: Int? {
        switch self {
        case .responseHasNoData(let code, _):
            return code
        default: return nil
        }
    }

    /// Server回傳的 errorMessage
    var message: String? {
        switch self {
        case .responseHasNoData(_, let _msg):
            return _msg
        default: return nil
        }
    }
}

struct EmptyDecodable: Decodable {}

