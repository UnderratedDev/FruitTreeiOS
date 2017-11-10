//
//  FirstViewController.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications
import Firebase
import FirebaseDatabase

class FirstViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var observer: NSObjectProtocol?
    var selfAnnotation: MKPointAnnotation?
    
    var centered: Bool = false
    
    var staticFruits = [Fruit]()
    var staticFruitTrees = [FruitTree]()
    var staticFruitTreeMarkerMap: Dictionary<FruitTree, MKAnnotation> = Dictionary<FruitTree, MKAnnotation>()
    
    // firebase database references
    lazy var ref: DatabaseReference = Database.database().reference()
    
    var fruitsRef: DatabaseReference!
    var fruittreesRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.delegate = self
        
        // firebase database reference of static kits
        fruitsRef = ref.child ("Fruit")
        fruittreesRef = ref.child ("FruitTree")
        
        observer = Notifications.addObserver (messageName: Location.LOCATION_CHANGED, object: nil) { _ in
            self.updateUserLocation (location: Location.currentLocation)
        }
        
        Location.startLocationUpdatesWhenInUse(caller: self)
        var coord: CLLocationCoordinate2D! = appDelegate.locationManager.location?.coordinate
        
        if coord != nil {
            let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
            
            selfAnnotation = MKPointAnnotation()
            selfAnnotation?.coordinate = coord
            
            centerMapOnLocation (location: location)
            // MapView.addAnnotation (selfAnnotation!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Listen for new fruits in the Firebase database
        // it is aysn.kits will be added one by one;
        //
        fruitsRef.observe(.childAdded, with: {[weak self] (snapshot) -> Void in
            
            print("childAdded")
            
            if let fruit = Fruit(From: snapshot) {
                
                self?.staticFruits.append(fruit)
                
                //debug info
                print("start printing\n")
                print("\(self?.staticFruits.count ?? -1)")
            }
            
        })
        
        // Listen for deleted fruits in the Firebase database
        fruitsRef.observe(.childRemoved, with: { [weak self] (snapshot) -> Void in
            
            print("childRemoved")
            
            // get value as dictionary
            guard let dict = snapshot.value as? [String:Any] else {
                print("childRemoved: Unable to parse snapshot.value from firebase!")
                return
            }
        })
        
        // Listen for deleted fruits in the Firebase database
        fruitsRef.observe(.childChanged, with: { [weak self] (snapshot) -> Void in
            
            print("childChanged")
            
        })
        
        fruittreesRef.observe(.childAdded, with: {[weak self] (snapshot) -> Void in
            
            print("childAdded")
            
            if let fruittree = FruitTree(From: snapshot) {
                
                self?.staticFruitTrees.append(fruittree)
                
                let newMarker = FruitTreeAnnotation ()
                
                newMarker.coordinate = CLLocationCoordinate2D(latitude: fruittree.coordinates.lat, longitude: fruittree.coordinates.lng)
                
                newMarker.title = fruittree.displayName
                
                if (fruittree.fruit.name == "Apple") {
                    newMarker.image = #imageLiteral(resourceName: "Apple")
                } else if (fruittree.fruit.name == "Orange") {
                    newMarker.image = #imageLiteral(resourceName: "Orange")
                } else if (fruittree.fruit.name == "Lemon") {
                    newMarker.image = #imageLiteral(resourceName: "Lemon")
                } else {
                    newMarker.image = #imageLiteral(resourceName: "Tree")
                }
                
                /*
                let newMarker = Marker (title: fruittree.displayName,
                                        locationName: fruittree.displayName,
                    discipline: "Fruit Tree",
                    coordinate: CLLocationCoordinate2D(latitude: fruittree.coordinates.lat, longitude: fruittree.coordinates.lng)) */
                self?.MapView.addAnnotation(newMarker)
                self?.staticFruitTreeMarkerMap[fruittree] = newMarker
                
                //debug info
                print("start printing\n")
                print("\(self?.staticFruitTrees.count ?? -1)")
            }
            
        })
        
        // Listen for deleted fruittrees in the Firebase database
        fruittreesRef.observe(.childRemoved, with: { [weak self] (snapshot) -> Void in
            
            print("childRemoved")
            
            // get value as dictionary
            guard let dict = snapshot.value as? [String:Any] else {
                print("childRemoved: Unable to parse snapshot.value from firebase!")
                return
            }
        })
        
        // Listen for deleted fruittrees in the Firebase database
        fruittreesRef.observe(.childChanged, with: { [weak self] (snapshot) -> Void in
            
            print("childChanged")
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        fruittreesRef.removeAllObservers()
        fruitsRef.removeAllObservers()
    }
    
    func updateUserLocation(location: CLLocation) {
        
        if !centered {
            centerMapOnLocation(location: location)
        }
        centered = true
        
        if self.selfAnnotation != nil {
            self.selfAnnotation!.coordinate = location.coordinate
            
        }
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location: CLLocation) {
        let doubleRegionRadius = regionRadius * 2.0;
        let coordinateRadius = MKCoordinateRegionMakeWithDistance (
            location.coordinate, doubleRegionRadius, doubleRegionRadius)
        MapView.setRegion (coordinateRadius, animated:true)
    }
    


}

