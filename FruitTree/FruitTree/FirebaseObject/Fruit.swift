//
//  Fruit.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Fruit: NSObject {
    var name: String
    
    // Used when getting data from firebase, creates a fruit object
    init?(From snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any] else {
            return nil
        }
        
        guard let name = dict["Name"] as? String else {
            return nil
        }
        
        self.name = name
    }
    
    init?(object: [String:Any]) {
        guard let name = object["Name"] as? String else {
            return nil
        }
        self.name = name
    }
}
