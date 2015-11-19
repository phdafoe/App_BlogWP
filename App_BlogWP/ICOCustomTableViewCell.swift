//
//  ICOCustomTableViewCell.swift
//  App_BlogWP
//
//  Created by User on 19/11/15.
//  Copyright © 2015 iCologic. All rights reserved.
//

import UIKit

class ICOCustomTableViewCell: UITableViewCell {
    
    
    //MARK: - IB
    
    @IBOutlet weak var myPostTitle: UILabel!
    @IBOutlet weak var myPOstDate: UILabel!
    @IBOutlet weak var myPostImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
