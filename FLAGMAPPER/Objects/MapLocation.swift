//
//  MapLocation.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2023-02-01.
//

import Foundation
import MapKit



extension CLLocationCoordinate2D: @retroactive CustomStringConvertible {
    public var description: String {
        return "\(String(format: "Lat: %.3f", self.latitude)) \(String(format: "Lon: %.3f", self.longitude)) "
    }
}
