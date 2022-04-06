//
//  Launch+Fixtures.swift
//  SpaceXInfoTests
//
//  Created by Gustavo Tiecker on 05/04/22.
//

import Foundation
import XCTest

@testable import SpaceXInfo

extension Launch {
    
    static func fixture(
        flightNumber: Int = 0,
        missionName: String = "",
        missionDetails: String = "",
        date: Date = Date(timeIntervalSinceReferenceDate: -123456789.0),
        rocketID: String = "",
        smallPatchURL: URL? = nil,
        largePatchURL: URL? = nil,
        campaignURL: URL? = nil,
        success: Bool = true
    ) -> Launch {
        .init(
            flightNumber: flightNumber,
            missionName: missionName,
            missionDetails: missionDetails,
            date: date,
            rocketID: rocketID,
            smallPatchURL: smallPatchURL,
            largePatchURL: largePatchURL,
            campaignURL: campaignURL,
            success: success
        )
    }
}
