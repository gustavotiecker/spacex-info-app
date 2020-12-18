//
//  SPXError.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import Foundation

enum SPXError: String, Error {
    case invalidRequest = "Invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data receveid from the server was invalid. Please try again."
}
