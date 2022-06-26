//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 17.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.separatorStyle = .none
        self.feedTableView.register(UINib(nibName: "FeedTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedTableViewCell")

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getFeed().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        let post = getFeed()[indexPath.row]
        cell.userImage.image = post.authorAvatar
        cell.userName.text = post.authorUsername
        cell.postTime.text = getTime(postTime: post.createdTime)
        cell.postLikes.text = "Likes: \(post.likedByCount)"
        cell.postImage.image = post.image
        cell.postText.text = post.description
        cell.buttonLike.tintColor = post.currentUserLikesThisPost ? .blue : .lightGray
        cell.postId = post.id
        cell.selectionStyle = .none
        
        // press like
        cell.closureLikePress = {
            switch cell.buttonLike.tintColor {
            case UIColor.blue:
                unLikePost(postId: post.id)
                cell.buttonLike.tintColor = .lightGray
            case UIColor.lightGray:
                likePost(postId: post.id)
                cell.buttonLike.tintColor = .blue
            default:
                break
            }
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
        //Go to profile
        cell.closureGoProfile = {
            userSelect.append(getUser(userID: post.author) ?? getCurrentUser())
            self.tabBarController?.selectedIndex = 1
        }
        
        //go to users likes
        cell.closureListLikes = {
            headerTable = "Likes"
            let vc = UIStoryboard(name:"Storyboard", bundle: nil)
            guard let followingVC = vc.instantiateViewController(withIdentifier: "FollowingTableViewController") as? FollowingTableViewController else {return}
            followingVC.users = getUserLike(postId: post.id) ?? []
            
            self.show(followingVC, sender: nil)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: post.authorUsername, style: .plain, target: nil, action: nil)
        }
        
        cell.closureImageTapped = {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
        return cell
    }
    
    
    
    func getTime(postTime: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: postTime)
    }
    
}
