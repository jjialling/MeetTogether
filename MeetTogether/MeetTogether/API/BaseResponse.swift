//
//  BaseResponse.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let resultData: T?
    let resultCode, resultMessage, requestID, clientMessage: String?

    enum CodingKeys: String, CodingKey {
        case resultData = "ResultData"
        case resultCode = "ResultCode"
        case resultMessage = "ResultMessage"
        case requestID = "RequestID"
        case clientMessage = "ClientMessage"
    }
}
