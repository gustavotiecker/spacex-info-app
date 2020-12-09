//
//  Launch.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import Foundation

struct Launch: Codable {
    //var links: Links
    var rocket: String
    var details: String
    var name: String
    var dateUtc: Date
}

//struct Links: Codable {
//    var patch: Patch
//    var reddit: Reddit
//}
//
//struct Patch: Codable {
//    var small: String?
//    var large: String?
//}
//
//struct Reddit: Codable {
//    var campaign: String?
//}
