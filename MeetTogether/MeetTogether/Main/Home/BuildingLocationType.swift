//
//  BuildingLocationType.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/8.
//

import UIKit

enum BuildingLocationType: CaseIterable {
    case stafford
    case oklahomaHall
    case campbell
    case technologyBrick
    case technologyStone
    case science
    case johnHaysAdministration
    case art
    case wellness
    
    var title: String {
        switch self {
        case .stafford:
            return "Stafford Canter"
        case .oklahomaHall:
            return "Oklahoma Hall"
        case .campbell:
            return "Campbell"
        case .technologyBrick:
            return "Technology Brick"
        case .technologyStone:
            return "Technology Stone"
        case .science:
            return "Science"
        case .johnHaysAdministration:
            return "John Hays Administration"
        case .art:
            return "Art"
        case .wellness:
            return "Wellness Center"
        }
    }
    
    var latitude: Double {
        switch self {
        case .stafford:
            return 35.53586267150601
        case .oklahomaHall:
            return 35.536594541868986
        case .campbell:
            return 35.53664476760478
        case .technologyBrick:
            return 35.53602463044464
        case .technologyStone:
            return 35.53597981945621
        case .science:
            return 35.535266329223454
        case .johnHaysAdministration:
            return 35.53527835110698
        case .art:
            return 35.535652030318964
        case .wellness:
            return 35.53622121139798
        }
    }
    
    var longitude: Double {
        switch self {
        case .stafford:
            return -98.70702937629584
        case .oklahomaHall:
            return -98.70668990802024
        case .campbell:
            return -98.7057113710768
        case .technologyBrick:
            return -98.70599714835541
        case .technologyStone:
            return -98.70547275808121
        case .science:
            return -98.70633271906296
        case .johnHaysAdministration:
            return -98.70776277182614
        case .art:
            return -98.70839646771061
        case .wellness:
            return -98.7097785769634
        }
    }
    
}
