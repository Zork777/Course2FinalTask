//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 18.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var labelPostId: UILabel!
    @IBOutlet weak var buttonUser: UIButton!
    
    var postId: Post.Identifier = ""
    var closureGoProfile: (()->())?
    var closureListLikes: (()->())?
    var closureLikePress: (()->())?
    var closureImageTapped: (()->())?
    
    @IBAction func buttonLikePress(_ sender: Any) {
        closureLikePress?()
    }
    
    @IBAction func buttonGoProfile(_ sender: Any) {
        closureGoProfile?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonLike.setTitle("", for: .normal)
        buttonUser.setTitle("", for: .normal)
        
        let tapGestureRecognizerImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizerImage.numberOfTapsRequired = 2
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapGestureRecognizerImage)
        
        let tapGestureRecognizerLike = UITapGestureRecognizer(target: self, action: #selector(likeTapped(tapGestureRecognizer:)))
        postLikes.isUserInteractionEnabled = true
        postLikes.addGestureRecognizer(tapGestureRecognizerLike)
        
    }

    
    @objc func likeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        closureListLikes?()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        likePost(postId: postId)
        buttonLike.tintColor = .blue
        
        let heart = UIImageView()
        heart.isUserInteractionEnabled = true
        heart.image = UIImage(named: "bigLike")
        heart.tintColor = .white
        
        self.addSubview(heart)
        heart.translatesAutoresizingMaskIntoConstraints = false
        heart.centerYAnchor.constraint(equalTo: postImage.centerYAnchor).isActive = true
        heart.centerXAnchor.constraint(equalTo: postImage.centerXAnchor).isActive = true
        
        let animationHeart1 = CABasicAnimation(keyPath: "opacity")
        animationHeart1.duration = 0.1
        animationHeart1.fromValue = 0
        animationHeart1.toValue = 1
        animationHeart1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let animationHeart2 = CABasicAnimation(keyPath: "opacity")
        animationHeart2.duration = 0.2
        animationHeart2.fromValue = 1
        animationHeart2.toValue = 1
        animationHeart2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let animationHeart3 = CABasicAnimation(keyPath: "opacity")
        animationHeart3.duration = 0.3
        animationHeart3.fromValue = 1
        animationHeart3.toValue = 0
        animationHeart3.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationHeart1, animationHeart2, animationHeart3]
        animationGroup.duration = 0.1+0.2+0.3
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        heart.layer.add(animationGroup, forKey: "opacity")
        heart.layer.opacity = 0
        
        closureImageTapped?()
    }
}
