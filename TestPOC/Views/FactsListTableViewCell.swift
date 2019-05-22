//
//  FactsListTableViewCell.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/22/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class FactsListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var factImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
