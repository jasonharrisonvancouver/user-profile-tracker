//
//  BrowseViewController.swift
//  Dinder
//
//  Created by Spencer Symington on 2019-01-30.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
  
  var currentEvent :UIView? //TODO make a custom class
  
  
    override func viewDidLoad() {
      super.viewDidLoad()
      print("loaded browse view controller")
      
      currentEvent = UIView(frame: self.view.frame)
      if let event = self.currentEvent{
        self.view.addSubview(event)
        currentEvent?.backgroundColor = UIColor.green
      }
     
    }
  @IBAction func swippedLeft(_ sender: Any) {
    print("swipped left")
    UIView.animate(withDuration: 1, animations: {
      //self.currentEvent?.backgroundColor = UIColor.blue
//      -self.view.frame.maxX
      self.currentEvent?.frame = CGRect(x: -300, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: {(true) in
      self.currentEvent?.removeFromSuperview()})
  }
  

  

}
