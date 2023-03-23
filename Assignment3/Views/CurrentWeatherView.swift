//
//  WeatherView.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import SwiftUI
import MapKit

struct CurrentWeatherView: View {

    let city : USCityModel
    @ObservedObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Current Weather")
                .font(.system(size: 20, weight: .bold))
                .padding()
            HStack {
                Text(city.capital + ",")
                Text(city.name)

            }.padding()
            ForEach(weatherVM.weatherData) { weather in
                ForEach(weather.weather) { w in
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(w.main)
                            Text(w.description)
                        }
                        .padding()
                    }
                }
                HStack {
                    Image(systemName: "thermometer")
                    Text("Current Temp: \(String(format: "%.0f", weather.main.temp))°")
                }
                .padding(.leading)
                
                Text("Feels Like Temp: \(String(format: "%.0f", weather.main.feels_like))°")
                
                HStack {
                    Image(systemName: "eyeglasses")
                    Text("Visibility: \(String(format: "%.0f", weather.visibility))")
                        .padding(.leading)
                }
                .padding(.leading)
                
                HStack {
                    Image(systemName: "wind")
                    Text("Wind Speed: \(String(format: "%.1f", weather.wind.speed))")
                        .padding(.leading)
                }
                .padding(.leading)
            }
            Spacer()
        }
        .task {
            await weatherVM.fetchData(lat: city.lat, lon: city.long)
        }
        .alert(isPresented: $weatherVM.hasError, error: weatherVM.error) {
            Text("")
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(city: USCityModel(abbr: "GA", name: "Georgia", capital: "Atlanta", lat: "33.76", long: "-84.39"))
    }
}
