//
//  Network.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import Foundation

struct Network {
    static let baseURL: String = "https://6e8e1b42-3d46-410a-bb0a-1f9fb93dd6f8-us-east1.apps.astra.datastax.com/api/rest/v2/namespaces/reviews/collections"
    
    static let bannerURL: String = "https://www.swosu.edu"
    
    static let apiHeader: [String: String] = ["X-Cassandra-Token":"AstraCS:lqasfdSeAEbcAwYbYBRnJuHf:c178598177c365a9cfb71138c2b1e2ea9282eaee4723e900ea3b327ab0c8ff39"]
    // test
}
