//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 17.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit
import Foundation
import DataProvider

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    
    @IBOutlet weak var userNameNavigationBar: UINavigationItem!
    
    
    
    private var imagePost: [UIImage] = []
    
    var user: User?

    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = userSelect.last

        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = (view.frame.size.width)/3
        layout.itemSize = CGSize(width: width, height: width)

        profileCollectionView.frame = .zero
        profileCollectionView?.collectionViewLayout = layout
        profileCollectionView?.register(ProfileImageCollectionViewCell.nib(),
                                        forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        profileCollectionView?.register(ProfileHeaderCollectionReusableView.nib(),
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
        profileCollectionView?.delegate = self
        profileCollectionView?.dataSource = self
        profileCollectionView?.backgroundColor = .white
        view.addSubview(profileCollectionView!)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileCollectionView?.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userNameNavigationBar.title = user?.username
        let topOffest = CGPoint(x: 0, y: 0)
        self.profileCollectionView?.setContentOffset(topOffest, animated: true)
        
        if let posts = getAllpostUser(userID: user!.id){
            imagePost.removeAll()
            for post in posts {
                self.imagePost.append(post.image)
            }
        }
        profileCollectionView?.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath)
        
            if let cellView = cellView as? ProfileImageCollectionViewCell {
                let photo = self.imagePost[indexPath.row]
                cellView.configure(image: photo)
            }
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! ProfileHeaderCollectionReusableView
        header.configure(user: user!)
        
        header.closureGoFollowers = {
            headerTable = "Followers"
            let vc = UIStoryboard(name:"Storyboard", bundle: nil)
            guard let followingVC = vc.instantiateViewController(withIdentifier: "FollowingTableViewController") as? FollowingTableViewController else {return}
            if let users = getUserFollowers(userID: self.user!.id){
                followingVC.users = users
                self.show(followingVC, sender: nil)
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: self.user!.username, style: .plain, target: nil, action: nil)
            }
        }
        
        header.closureGoFollowing = {
            headerTable = "Following"
            let vc = UIStoryboard(name:"Storyboard", bundle: nil)
            guard let followingVC = vc.instantiateViewController(withIdentifier: "FollowingTableViewController") as? FollowingTableViewController else {return}
            
            if let users = getUserFollowing(userID: self.user!.id){
                followingVC.users = users
                self.show(followingVC, sender: nil)
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: self.user!.username, style: .plain, target: nil, action: nil)
                }
            
        }
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: heightProfileHeader)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidLoad()
        self.viewWillAppear(true)
    }

}
