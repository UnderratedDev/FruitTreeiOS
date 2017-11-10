//
//  Marker.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import MapKit

class Marker : NSObject, MKAnnotation {
    let title:String?
    let locationName:String
    let discipline:String
    let coordinate:CLLocationCoordinate2D
    
    init(title:String, locationName:String, discipline:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init ()
    }
    
    var subtitle:String? {
        return locationName
    }
    
}
