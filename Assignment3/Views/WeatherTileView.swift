//
//  WeatherTileView.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/23/23.
//

import SwiftUI

struct WeatherTileView: View {
    var weather : WeatherTileModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: weather.icon)
                Text(weather.label)
            }
            Spacer()
            Text(weather.weatherItem)
                .font(.system(size: 20))
        }
        .font(.system(size: 15))
        .frame(width: 120, height: 60)
        .padding()
    }
}

struct WeatherTileView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTileView(weather: WeatherTileModel(weatherItem: "73°", icon: "equal.circle", label: "Current Temp"))
    }
}
