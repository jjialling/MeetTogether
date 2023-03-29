//
//  BuildingTimeViewModel.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/29.
//

import Combine
import Moya

class BuildingTimeViewModel {
    @Published var buildingTimeList: [String:BuildingTimeList] = [:]

    private(set) var errorMessage = PassthroughSubject<String?, Never>()
    
}
extension BuildingTimeViewModel {
    func fetchBuildingTimeList() {
        let targetType = BuildingTimeAPI.BuildingTimeList()
        APIManager.shared.request(targetType) { result in
            switch result {
            case .success(let response):
                self.buildingTimeList = response?.data ?? [:]
            case .failure(let error):
                self.errorMessage.send(error.message)
            }
        }
    }
}
