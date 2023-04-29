//
//  EventDetailViewModel.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/4/24.
//

import UIKit
import Combine
import Moya

class EventDetailViewModel {
    @Published var eventDetail: EventDetailResponse?

    private(set) var errorMessage = PassthroughSubject<String?, Never>()
    
}
extension EventDetailViewModel {
    func fetchEventDetail(id: String) {
        let targetType = EventsAPI.EventDetail(eventDetailID: id)
        APIManager.shared.request(targetType) { result in
            switch result {
            case .success(let response):
                self.eventDetail = response
            case .failure(let error):
                self.errorMessage.send(error.message)
            }
        }
    }
}
