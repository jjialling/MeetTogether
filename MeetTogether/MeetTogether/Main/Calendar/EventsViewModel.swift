//
//  EventsViewModel.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation
import Combine
import Moya

class EventsViewModel {
    @Published var eventList: [String:EventList] = [:]

    private(set) var errorMessage = PassthroughSubject<String?, Never>()
    
    let NetworkProvider = MoyaProvider<EventsAPI.EventsList>()
    
}
extension EventsViewModel {
    func fetchEventList() {
        let targetType = EventsAPI.EventsList()
        APIManager.shared.request(targetType) { result in
            switch result {
            case .success(let response):
                self.eventList = response?.data ?? [:]
            case .failure(let error):
                self.errorMessage.send(error.message)
            }
        }
    }
}
