//
//  FMLocation.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2023-02-01.
//

import Foundation
import MapKit

struct FMLocation{
    let latitude: Double
    let longitude: Double
    //id of an FMFlag
    let flagList = [(UUID, count: Int)]()
    let name = ""
    let desc = ""
    
    func equals(compare : FMLocation) -> Bool{
        return (compare.longitude == self.longitude && compare.latitude == self.latitude)
    }
}

extension FMLocation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
