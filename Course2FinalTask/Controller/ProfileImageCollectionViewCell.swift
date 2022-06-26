//
//  ProfileImageCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 20.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var postImage: UIImageView!
    
    static let identifier = "ProfileImageCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ProfileImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    func configure (image: UIImage){
        postImage.image = image
    }

}
