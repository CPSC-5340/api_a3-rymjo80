//
//  WeatherModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import Foundation

struct ListModel : Codable, Identifiable {
    var id : UUID {
        return UUID()
    }
    let main : MainModel
    let weather : [WeatherModel]
    let wind : WindModel
    let visibility : String
}

struct WeatherResults : Codable {
    let cod : String
    let message : String
    let cnt : String
    let list : [ListModel]
    let city : CityModel
    let country: String
    let population : String
    let timezone: String
    let sunrise: String
    let sunset: String
}
