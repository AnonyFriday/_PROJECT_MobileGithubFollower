//
//  Follower.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 18/10/20.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
    
    static func == (rhs: Follower, lhs: Follower) -> Bool {
        return rhs.login == lhs.login
    }
}

