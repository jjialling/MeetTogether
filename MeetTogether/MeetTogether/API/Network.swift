//
//  Network.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import Foundation

struct Network {
    static let baseEventURL: String = "https://6e8e1b42-3d46-410a-bb0a-1f9fb93dd6f8-us-east1.apps.astra.datastax.com/api/rest/v2/namespaces/reviews/collections"
    
    static let baseBuildingURL: String = "https://0ce32097-90ca-4027-ae5f-ba23df2adc3d-us-east1.apps.astra.datastax.com/api/rest/v2/namespaces/building/collections"
    
    static let bannerURL: String = "https://www.swosu.edu"
    
    static let apiEventHeader: [String: String] = ["X-Cassandra-Token":"AstraCS:lqasfdSeAEbcAwYbYBRnJuHf:c178598177c365a9cfb71138c2b1e2ea9282eaee4723e900ea3b327ab0c8ff39"]
    
    static let apiBuildingHeader: [String: String] = ["X-Cassandra-Token":"AstraCS:jFNZhplKUHiGkWcvKxUuaLWl:0a6b260749a50c0871d0ba79b8c6931aa50d1d4fd62474eabb01e8db7a3bc8d1"]

}
