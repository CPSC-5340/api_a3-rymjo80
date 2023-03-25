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
                ForEach(usCitiesVM.cityData) { state in
                    NavigationLink {
                        CurrentWeatherView(city: state)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(state.capital + ",")
                                Text(state.abbr)
                            }
                        }
                    }
                }
            }.onAppear() {
                usCitiesVM.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("Weather: US Capitals")
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
