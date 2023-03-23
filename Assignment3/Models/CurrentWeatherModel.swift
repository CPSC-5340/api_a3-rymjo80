//
//  WeatherModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import Foundation

struct CurrentWeatherModel : Codable, Identifiable {
    var id : UUID {
        return UUID()
    }
    let weather : [WeatherModel]
    let main : MainModel
    let visibility : Int
    let wind : WindModel
    let sys : SysModel
    let name : String
    let coord : CoordModel
}
