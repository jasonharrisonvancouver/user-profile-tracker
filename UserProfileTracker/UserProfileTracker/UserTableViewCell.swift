//
//  UserTableViewCell.swift
//  UserProfileTracker
//
//  Created by jason harrison on 2019-02-18.
//  Copyright © 2019 jason harrison. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
