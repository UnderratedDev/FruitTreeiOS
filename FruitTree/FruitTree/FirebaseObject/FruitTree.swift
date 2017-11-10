//
//  FruitTree.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FruitTree: NSObject {
    var fruit: Fruit
    var displayName: String
    var coordinates: Coordinates
    
    init?(From snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        
        guard let name = dict["DisplayName"] as? String else {
            return nil
        }
        
        guard let coordinatesObject = dict["Location"] as? [String: Double] else {
            return nil
        }
        
        guard let fruit = dict["Fruit"] as? [String:Any] else {
            return nil
        }
        
        self.displayName = name
        self.coordinates = Coordinates(coorOJ: coordinatesObject)
        self.fruit = Fruit(object: fruit)!
        
    }
}

class Coordinates: NSObject {
    var lat: Double
    var lng: Double
    
    init (coorOJ: [String: Double]) {
        lat = coorOJ["Lat"]!
        lng = coorOJ["Lng"]!
    }
    
    override var description: String {
        return "lat : \(lat)\n long: \(lng)"
    }
}
