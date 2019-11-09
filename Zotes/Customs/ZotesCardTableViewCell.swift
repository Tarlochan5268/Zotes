//
//  ZotesCardTableViewCell.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-09.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class ZotesCardTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateAndLocation: UILabel!
    
    @IBOutlet weak var sampleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
