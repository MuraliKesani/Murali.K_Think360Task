//
//  TableViewCell.swift
//  Murali.K_Think360Task
//
//  Created by Murali on 5/24/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var imageLogo: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var qualificationLabel: UILabel!
    @IBOutlet var identityLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var videoCallButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageLogo.layer.cornerRadius = imageLogo.frame.width/2
        imageLogo.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
