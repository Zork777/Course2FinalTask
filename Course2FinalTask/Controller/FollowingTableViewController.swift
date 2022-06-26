//
//  FollowingTableViewController.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 23.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FollowingTableViewController: UITableViewController {
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = headerTable
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 45
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].username
        cell.imageView?.image = users[indexPath.row].avatar
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelect.append(users[indexPath.row])
        let vc = UIStoryboard(name:"Storyboard", bundle: nil)
        guard let followingVC = vc.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        followingVC.user = users[indexPath.row]
        performSegue(withIdentifier: "toProfile", sender: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            _ = userSelect.popLast()
        }
    }
    
}
