//
//  Launch.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import UIKit

struct Launch {
    let flightNumber: Int
    let missionName: String
    let missionDetails: String
    let date: Date
    let rocketID: String
    let smallPatchURL: URL?
    let largePatchURL: URL?
}

extension Launch: Decodable {
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "name"
        case missionDetails = "details"
        case date = "date_utc"
        case rocketID = "rocket"
        case links

        enum LinksKeys: String, CodingKey {
            case patch = "patch"

            enum PatchKeys: String, CodingKey {
                case smallPatch = "small"
                case largePatch = "large"
            }
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        missionName = try container.decode(String.self, forKey: .missionName)
        missionDetails = try container.decode(String.self, forKey: .missionDetails)
        date = try container.decode(Date.self, forKey: .date)
        rocketID = try container.decode(String.self, forKey: .rocketID)

        let linksContainer = try container.nestedContainer(keyedBy: CodingKeys.LinksKeys.PatchKeys.self, forKey: .links)
        smallPatchURL = try linksContainer.decode(URL.self, forKey: .smallPatch)
        largePatchURL = try linksContainer.decode(URL.self, forKey: .largePatch)
    }
}
