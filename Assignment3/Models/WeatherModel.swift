//
//  WeatherModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import Foundation

struct WeatherModel : Codable, Identifiable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}
