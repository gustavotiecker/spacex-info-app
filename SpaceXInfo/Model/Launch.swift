//
//  Launch.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import Foundation

struct Launch {
    let flightNumber: Int
    let missionName: String
    let missionDetails: String
    let date: Date
    let rocketID: String
    let landingType: String?
    
}

extension Launch: Decodable {
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "name"
        case missionDetails = "details"
        case date = "date_utc"
        case rocketID = "rocket"
        case landingType
    }
    
    enum CoresKeys: String, CodingKey {
        case landingType = "landing_type"
    }
    
    init(from decoder: Decoder) throws { }
}
