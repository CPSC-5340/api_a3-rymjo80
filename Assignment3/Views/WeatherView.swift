//
//  WeatherView.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    CityView()
                } label: {
                    Text("City Name")
                }

            }
            .navigationTitle("Current Weather")
            .listStyle(.grouped)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
