//
//  ProfileHeaderCollectionReusableView.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 20.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    var userID: User.Identifier?
    var closureGoFollowers: (()->())?
    var closureGoFollowing: (()->())?
    
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    static func nib() -> UINib{
        return UINib(nibName: "ProfileHeaderCollectionReusableView", bundle: nil)
    }
    
    
    func configure (user: User){
        postImage.layer.cornerRadius = postImage.bounds.width / 2
        postImage.image = user.avatar
        labelFullName.text = user.fullName
        userID = user.id
        labelFollowers.text = "Followers: \(user.followedByCount)"
        labelFollowing.text = "Following: \(user.followsCount)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizerFollowers = UITapGestureRecognizer(target: self, action: #selector(tapLabelFollowers(tapGestureRecognizer:)))
        labelFollowers.isUserInteractionEnabled = true
        labelFollowers.addGestureRecognizer(tapGestureRecognizerFollowers)
        
        let tapGestureRecognizerFollowing = UITapGestureRecognizer(target: self, action: #selector(tapLabelFollowing(tapGestureRecognizer:)))
        labelFollowing.isUserInteractionEnabled = true
        labelFollowing.addGestureRecognizer(tapGestureRecognizerFollowing)
    }
    
    
    @objc func tapLabelFollowers(tapGestureRecognizer: UITapGestureRecognizer){
        closureGoFollowers?()
    }
    
    @objc func tapLabelFollowing(tapGestureRecognizer: UITapGestureRecognizer){
       closureGoFollowing?()
        
    }
}
