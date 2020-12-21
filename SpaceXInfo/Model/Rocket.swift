//
//  Rocket.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 15/12/20.
//

import Foundation

struct Rocket {
    let name: String
    let isActive: Bool
    let successRatePct: Int
    let country: String
    let company: String
    let description: String
    let wikipediaURL: URL
    let images: [URL]
    
    let height: Float
    let diameter: Float
    let mass: Int
}

extension Rocket: Decodable {
    enum RocketKeys: String, CodingKey {
        case name = "name"
        case isActive = "active"
        case successRatePct = "success_rate_pct"
        case country = "country"
        case company = "company"
        case description = "description"
        case wikipediaURL = "wikipedia"
        case images = "flickr_images"
        case height
        case diameter
        case mass
        
        enum HeightKeys: String, CodingKey {
            case height = "meters"
        }
        
        enum DiameterKeys: String, CodingKey {
            case diameter = "meters"
        }
        
        enum MassKeys: String, CodingKey {
            case mass = "kg"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RocketKeys.self)
        name = try container.decode(String.self, forKey: .name)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        successRatePct = try container.decode(Int.self, forKey: .successRatePct)
        country = try container.decode(String.self, forKey: .country)
        company = try container.decode(String.self, forKey: .company)
        description = try container.decode(String.self, forKey: .description)
        wikipediaURL = try container.decode(URL.self, forKey: .wikipediaURL)
        images = try container.decode([URL].self, forKey: .images)
        
        let heightContainer = try container.nestedContainer(keyedBy: RocketKeys.HeightKeys.self, forKey: .height)
        height = try heightContainer.decode(Float.self, forKey: .height)
        
        let diameterContainer = try container.nestedContainer(keyedBy: RocketKeys.DiameterKeys.self, forKey: .diameter)
        diameter = try diameterContainer.decode(Float.self, forKey: .diameter)
        
        let massContainer = try container.nestedContainer(keyedBy: RocketKeys.MassKeys.self, forKey: .mass)
        mass = try massContainer.decode(Int.self, forKey: .mass)
    }
}
