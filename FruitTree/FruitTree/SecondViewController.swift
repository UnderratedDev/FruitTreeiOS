//
//  SecondViewController.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import Eureka

class
SecondViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        form +++ Section("Tree")
            <<< TextRow() {
                $0.tag = "Lat"
                $0.title = "Lat"
                $0.placeholder = "123"
            }
            <<< TextRow() {
                $0.tag = "Lng"
                $0.title = "Lng"
                $0.placeholder = "-34"
            }
            <<< TextRow() {
                $0.tag = "Name"
                $0.title = "Name"
                $0.placeholder = "Apple Tree"
            }
            <<< TextRow() {
                $0.tag = "Fruit"
                $0.title = "Fruit"
                $0.placeholder = "Apple"
            }
            <<< ButtonRow() {
                $0.title = "Submit"
                $0.onCellSelection (self.submitTree)
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitTree(cell: ButtonCellOf<String>, row: ButtonRow) {
        print("tapped!")
        // Get all values in form as an array, including hidden
        let dict = form.values (includeHidden: true)
        
        // Only run code to post and validate if the value are not nil, except for comments
        if
            let lat:String = dict["Lat"] as? String,
            let lng:String = dict["Lng"] as? String,
            let name:String = dict["Name"] as? String,
            let fruit:String = dict["Fruit"] as? String {
            
            print (lat)
            print (lng)
            print (name)
            print (fruit)
        
        } else {
            // Alert the user that there are fields that have not been filled out
            // Create an alert to alert the user to check empty fields
            let alert = UIAlertController(title: "Please fill out the form", message: "Missing fields", preferredStyle: UIAlertControllerStyle.alert)
            
            // Add okay action to alert, to return back to the form
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            
            // Present the alert to the user
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    

}

