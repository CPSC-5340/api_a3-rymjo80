//
//  WeatherViewModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import Foundation

class WeatherViewModel : ObservableObject {
    
    @Published private(set) var weatherData = [CurrentWeatherModel]()
    @Published private(set) var weatherTileArray = [WeatherTileModel]()
    @Published var hasError = false
    @Published var error : WeatherModelError?
    private let api_key = "4db4feca549bd87f16d2e52cb760a715"

   
    @MainActor
    func fetchData(lat: String, lon: String) async {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(api_key)&units=imperial") {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let results = try JSONDecoder().decode(CurrentWeatherModel?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = WeatherModelError.decodeError
                    return
                }
                self.weatherData = [results]
                getWeatherTileArray()
            } catch {
                self.hasError.toggle()
                self.error = WeatherModelError.customError(error: error)
            }
        }
    }
    
    func getWeatherTileArray() {

        for weather in self.weatherData {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: weather.timezone)
            formatter.dateFormat = "h:mm:ss a"
            
            let sunrise = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
            let sunset = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
            
            
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(formatter.string(from: sunrise))", icon: "sunrise", label: "Sunrise"))
            
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(formatter.string(from: sunset))", icon: "sunset", label: "Sunset"))
            
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(String(format: "%.0f", weather.main.temp))°", icon: "thermometer", label: "Current Temp"))
            
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(String(format: "%.0f", weather.main.feels_like))°", icon: "equal.circle", label: "Feels Like"))
                                    
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(String(format: "%.0f", weather.main.temp_max))°", icon: "thermometer.high", label: "Max Temp*"))
            
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(String(format: "%.0f", weather.main.temp_min))°", icon: "thermometer.low", label: "Min Temp*"))
            
            weatherTileArray.append(WeatherTileModel(weatherItem: "\(String(format: "%.0f", weather.wind.speed)) mph", icon: "wind", label: "Wind Speed"))
            
            if let humidity = weather.main.humidity {
                weatherTileArray.append(WeatherTileModel(weatherItem: "\(humidity)%", icon: "humidity", label: "Humidity"))
            }
        }
    }
}

extension WeatherViewModel {
    enum WeatherModelError : LocalizedError {
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            }
        }
    }
}
