//
//  ViewController.swift
//  FamousPeople
//
//  Created by jason harrison on 2019-02-12.
//  Copyright © 2019 jason harrison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            let db = try DataManager()
            let people = try db.getAllFamousPeople()
            for person in people {
                print(person.firstName)
            }
        } catch let error {
            print("Error \(error)")
        }
        
    }


}

