//
//  WeatherListViewRow.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import SwiftUI

struct WeatherListView: View {
    
    @State var weather: WeatherResponse
    
    var body: some View {
        HStack(spacing: 10.0) {
            VStack(alignment: .leading, spacing: 5.0) {
                HStack(spacing: 5.0) {
                    Text("Date: ").bold().foregroundColor(.black)
                    Text(weather.dataTime).bold().foregroundColor(.gray)
                }
                HStack(spacing: 5.0) {
                    Text("City: ").bold().foregroundColor(.black)
                    Text(weather.name ?? "").foregroundColor(.gray)
                }
                HStack(spacing: 5.0) {
                    Text("Description: ").bold().foregroundColor(.black)
                    Text(weather.weather.first?.weatherDescription?.rawValue ?? "").foregroundColor(.gray)
                }
                HStack(spacing: 5.0) {
                    Text("Temperature: ").bold().foregroundColor(.black)
                    Text("\(weather.main.tempMin?.formattedCelcius ?? "0.0") Low / \(weather.main.tempMax?.formattedCelcius ?? "0.0") High").foregroundColor(.gray)
                }
                HStack(spacing: 5.0) {
                    Text("Wind: ").bold().foregroundColor(.black)
                    Text(String(format: "%0.2f m / s", weather.wind?.speed ?? 0.0)).foregroundColor(.gray)
                }
            }
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).background(Color.clear, alignment: .leading)
    }
}
