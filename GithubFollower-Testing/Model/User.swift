//
//  User.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 18/10/20.
//

import Foundation

class User: Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.login == rhs.login
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
    
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let publicRepos: Int
    let publicGists: Int
    var bio: String?
    var location: String?
    let createdAt: Date
    let followers: Int
    let following: Int
    var name: String?
    
}

