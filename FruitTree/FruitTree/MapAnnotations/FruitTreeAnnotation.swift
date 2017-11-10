//
//  FruitTreeAnnotation.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import MapKit

class FruitTreeAnnotation: MKPointAnnotation, AbstractAnnotation {
    let identifier = "fruittree-annotation"
    let color = UIColor.red
    var image = #imageLiteral(resourceName: "Tree")
    let defaultTitle = "Overdose"
}

