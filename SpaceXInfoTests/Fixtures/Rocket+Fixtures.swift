//
//  Rocket+Fixtures.swift
//  SpaceXInfoTests
//
//  Created by Gustavo Tiecker on 05/04/22.
//

import Foundation
import XCTest

@testable import SpaceXInfo

extension Rocket {
    
    static func fixture(
        name: String = "",
        isActive: Bool = true,
        successRatePct: Int = 0,
        country: String = "",
        company: String = "",
        description: String = "",
        wikipediaURL: URL = URL(string: "www.test.com")!,
        images: [URL] = [],
        height: Float = 0.1,
        diameter: Float = 0.1,
        mass: Int = 0
    ) -> Rocket {
        .init(
            name: name,
            isActive: isActive,
            successRatePct: successRatePct,
            country: country,
            company: company,
            description: description,
            wikipediaURL: wikipediaURL,
            images: images,
            height: height,
            diameter: diameter,
            mass: mass
        )
    }
}
