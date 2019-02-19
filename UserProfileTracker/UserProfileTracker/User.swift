//
//  User.swift
//  UserProfileTracker
//
//  Created by jason harrison on 2019-02-18.
//  Copyright © 2019 jason harrison. All rights reserved.
//

import UIKit
import os.log


class User: NSObject, NSCoding{
    var firstName: String
    var photo: UIImage?
    var rating: Int
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("theusers")

    
    //MARK: Types
    
    struct PropertyKey {
        static let firstName = "firstName"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    
    
    
    //MARK: Initialization
    
    init?(firstName: String, photo: UIImage?, rating: Int) {
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !firstName.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.firstName = firstName
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: PropertyKey.firstName)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let firstName = aDecoder.decodeObject(forKey: PropertyKey.firstName) as? String else {
            os_log("Unable to decode the first name for a User object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(firstName: firstName, photo: photo, rating: rating)
        
    }
}
