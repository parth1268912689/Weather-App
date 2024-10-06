//
//  WeatherView.swift
//  Weather
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                    VStack(spacing: 10) {
                        HStack(spacing: 8) {
                            VStack() {
                                TextField("Please enter city name", text: self.$viewModel.searchText, onEditingChanged: { (edit) in
                                    
                                }) {
                                  UIApplication.shared.endEditing()
                                    }.keyboardType(.alphabet).disableAutocorrection(true)
                                Rectangle().frame(height: 1.0)
                                    .padding(.horizontal, 0.0).foregroundColor(Color.gray)
                            }
                            Button(action: {
                                UIApplication.shared.endEditing()
                                self.viewModel.validateSearchArray()
                            }) {
                                Image(systemName: "magnifyingglass").padding().foregroundColor(.black)
                            }
                        }.padding()
                        List {
                            ForEach(self.viewModel.currentWeather) { weather in
                                Section(header: Text(weather.name)) {
                                    ForEach(weather.weather) { item in
                                        WeatherListView(weather: item)
                                     }
                                }
                            }
                        }.listStyle(GroupedListStyle())
                            .alert(isPresented: self.$viewModel.isErrorShown, content: { () -> Alert in
                                Alert(title: Text("Error"), message: Text(self.viewModel.errorMessage))
                        })
                }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
            }
            .navigationBarTitle(Text("Weather"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct CurrentWeatherListView_Previews : PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
#endif

