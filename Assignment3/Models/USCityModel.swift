//
//  USCityModel.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/19/23.
//

import Foundation

struct USCityModel : Codable, Identifiable {
    var id : UUID {
        return UUID()
    }
    let abbr: String
    let name: String
    let capital: String
    let lat: String
    let long: String
}

struct USCityResults : Codable {
    let states : [USCityModel]
}
