//
//  City.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation

struct City: Codable, Equatable {

    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}
