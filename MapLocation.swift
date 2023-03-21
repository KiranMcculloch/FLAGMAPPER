//
//  MapMarker.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2023-02-01.
//

import Foundation
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
}

extension MapLocation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
