//
//  TabBarViewController.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 22.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import UIKit


class TabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        userSelect.append(getCurrentUser())
    }
    
        
    

    
}
