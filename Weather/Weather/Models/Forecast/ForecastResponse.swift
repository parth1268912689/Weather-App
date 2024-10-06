//
//  ForecastResponse.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation

struct ForecastResponse: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [Forecast]
    let city: City
}

struct PresentableForecast: Identifiable {
    let weekDay: String
    let name: String
    let forecast: [Forecast]
    var id: String {
        return weekDay
    }
}
