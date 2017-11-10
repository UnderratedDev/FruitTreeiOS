//
//  FruitTreeAnnotation.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import MapKit

protocol AbstractAnnotation: MKAnnotation {
    var image: UIImage { get }
    var identifier: String { get }
    
    var defaultTitle: String { get }
}
