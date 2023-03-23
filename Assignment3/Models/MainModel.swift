//
//  MainModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import Foundation

struct MainModel : Codable {
    var id : UUID {
        return UUID()
    }
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Int?
    let humidity : Int?
    let sea_level : Int?
    let grnd_level : Int?
}
