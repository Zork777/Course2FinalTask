//
//  FollowingTableViewCell.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 26.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
    }
}
