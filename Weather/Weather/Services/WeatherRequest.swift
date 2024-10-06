//
//  WeatherRequest.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation

struct WeatherRequest: APIRequestType {
    
    typealias Response = WeatherResponse
    
    init(_ params: [String: String]) {
        queryParams = params
    }
    
    var queryParams: [String : String]
    var path: String { return "/data/2.5/weather" }
    var queryItems: [URLQueryItem]? {
        return queryParams.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
}
