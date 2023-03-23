//
//  WeatherViewModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import Foundation

class WeatherViewModel : ObservableObject {
    
    @Published private(set) var weatherData = [CurrentWeatherModel]()
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
            } catch {
                self.hasError.toggle()
                self.error = WeatherModelError.customError(error: error)
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
