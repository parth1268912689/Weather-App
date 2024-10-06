//
//  WeatherApp.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel(apiService: APIService()))
        }
    }
}
