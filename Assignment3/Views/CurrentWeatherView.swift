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
        ScrollView {
            MapView(coordinate: CLLocationCoordinate2D(latitude: Double(city.lat)!, longitude: Double(city.long)!))
                .frame(height: 200)
            
            VStack {
                Text("Current Weather")
                    .padding(.leading)
                    .font(.largeTitle)
                
                HStack {
                    Text(city.capital + ",")
                    Text(city.abbr)
                }
                .font(.title2)
                .padding(.leading)
            }
            
            VStack {
                ForEach(weatherVM.weatherData) { weather in
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(weatherVM.weatherTileArray, id: \.self) { tile in
                            WeatherTileView(weather: tile)
                        }
                    }
                }
            }
            Spacer()
            VStack {
                Text("* Max Temp is the current max temp in the city.")
                Text("* Min Temp is the current min temp in the city.")
            }
            .font(.system(size: 12))
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
