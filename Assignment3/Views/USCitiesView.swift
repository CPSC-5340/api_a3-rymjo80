//
//  CityView.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/17/23.
//

import SwiftUI

struct USCitiesView: View {
    
   @ObservedObject var usCitiesVM = USCitiesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(usCitiesVM.cityData) { city in
                    NavigationLink {
                        CurrentWeatherView(city: city)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(city.capital + ",")
                                Text(city.abbr)
                            }
                        }
                    }
                }
            }.onAppear() {
                usCitiesVM.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("US Cities")
            .alert(isPresented: $usCitiesVM.hasError, error: usCitiesVM.error) {
                Text("")
            }
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        USCitiesView()
    }
}
