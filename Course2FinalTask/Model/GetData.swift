//
//  GetData.swift
//  Course2FinalTask
//
//  Created by Евгений Захаров on 17.02.2022.
//  Copyright © 2022 e-Legion. All rights reserved.
//

import Foundation
import DataProvider

let heightProfileHeader: CGFloat = 70+8*2

var userSelect: [User] = []
//var userSelect: User?

var headerTable: String = ""

func listUser() -> [String]{
    var userList: [String] = []
    for user in userSelect {
        userList.append(user.username)
        print (user.username)
    }
    return userList
}

func getFeed() -> [Post]{
    return DataProviders.shared.postsDataProvider.feed()
}

func likePost(postId: Post.Identifier){
    DataProviders.shared.postsDataProvider.likePost(with: postId)
}

func unLikePost(postId: Post.Identifier){
    DataProviders.shared.postsDataProvider.unlikePost(with: postId)
}

func getCurrentUser() -> User{
    return DataProviders.shared.usersDataProvider.currentUser()
}

func getUserLike(postId: Post.Identifier) -> [User]?{
    var users: [User] = []
    if let usersID = DataProviders.shared.postsDataProvider.usersLikedPost(with: postId){
        for userID in usersID{
            if let userProfile = DataProviders.shared.usersDataProvider.user(with: userID){
                users.append(userProfile)
            }
        }
        return users
    }
    return nil
}

func getUserFollowers(userID: User.Identifier) -> [User]? {
    let users = DataProviders.shared.usersDataProvider.usersFollowingUser (with: userID)
    if users!.isEmpty {return nil}
    return users
}

func getUserFollowing(userID: User.Identifier) -> [User]? {
    let users = DataProviders.shared.usersDataProvider.usersFollowedByUser (with: userID)
    if users!.isEmpty {return nil}
    return users
}


func getAllpostUser(userID: User.Identifier) -> [Post]? {
    return DataProviders.shared.postsDataProvider.findPosts(by: userID)
}

func getUser(userID: User.Identifier) -> User? {
    return DataProviders.shared.usersDataProvider.user(with: userID)
}


