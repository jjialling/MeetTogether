//
//  Network.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import Foundation

struct Network {
    static let baseURL: String = "https://63a6e650-c385-4cbb-a1c1-0c6dc4b3792c-us-east1.apps.astra.datastax.com/api/rest/v2/namespaces/app/collections"
    
    static let bannerURL: String = "https://www.swosu.edu"
    
    static let apiHeader: [String: String] = ["X-Cassandra-Token":"AstraCS:NyJzlUXhhTMMxMpsMgtZhrbB:65e0afc53dd7f532957bf5481e6d3c83236a49cfd3309aaa887792cccc3793a6"]

}
