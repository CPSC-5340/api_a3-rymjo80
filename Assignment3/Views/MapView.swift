//
//  MapView.swift
//  Assignment3
//
//  Created by Ryan Johnson on 3/23/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate : CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)))
    }
}

