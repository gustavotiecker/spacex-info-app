//
//  Rocket.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 15/12/20.
//

import Foundation

struct Rocket: Codable {
    
    struct Height: Codable {
        let meters: Float
    }
    
    struct Diameter: Codable {
        let meters: Float
    }
    
    struct Mass: Codable {
        let kg: Int
    }
    
    struct Engine: Codable {
        let number: Int
        let type: String
        let layout: String
        let propellant1: String
        let propellant2: String
    }
    
    let name: String
    let active: Bool
    let successRatePct: Int
    let country: String
    let company: String
    let description: String
    let wikipedia: URL
    let flickrImages: [URL]
    
    let height: Height
    let diameter: Diameter
    let mass: Mass
}
