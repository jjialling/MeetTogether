//
//  DecodableResponseTargetType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation
import Moya

/// 定義一個 protocol 需要預先指定 response 的 type
protocol DecodableResponseTargetType: TargetType {
    associatedtype Response: Decodable
}

