//
//  TableViewCell.swift
//  IRem
//
//  Created by HengQiang Cao on 12/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
