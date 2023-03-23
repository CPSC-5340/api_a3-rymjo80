//
//  USCitiesViewModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/19/23.
//

import Foundation

class USCitiesViewModel : ObservableObject {
    
    @Published private(set) var cityData = [USCityModel]()
    @Published var hasError = false
    @Published var error : USCityModelError?
    private let url = Bundle.main.url(forResource: "USCapitals", withExtension: "json")
    

    func fetchData() {
        if let url = self.url {
            do {
                let data = try Data(contentsOf: url)
                guard let results = try JSONDecoder().decode(USCityResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = USCityModelError.decodeError
                    return
                }
                self.cityData = results.states
            } catch {
                self.hasError.toggle()
                self.error = USCityModelError.customError(error: error)
            }
        } else {
            self.hasError.toggle()
            self.error = USCityModelError.sourceError
        }
    }
}

extension USCitiesViewModel {
    enum USCityModelError : LocalizedError {
        case sourceError
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .sourceError:
                return "Error: File cannot be found"
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            }
        }
    }
}
