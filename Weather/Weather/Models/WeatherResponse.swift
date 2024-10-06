//
//  WeatherResponse.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation

struct WeatherResponse: Codable, Identifiable {
    let coord: Coord?
    let weather: [Weather]
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    var dataTime: String {
        let epochTime = dt
        let newTime = Date(timeIntervalSince1970: TimeInterval(epochTime ?? Int(Date().timeIntervalSince1970)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.MMM_d_YYYY
        return dateFormatter.string(from: newTime)
    }
}

struct PresentableWeather: Identifiable {
    let name: String
    let weather: [WeatherResponse]
    var id: String {
        return name
    }
}
