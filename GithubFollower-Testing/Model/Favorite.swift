//
//  Favorite.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 8/11/20.
//

import Foundation

class Favorite: Hashable, Codable {
    
    //MARK: Global Variables
    let login: String
    let avatar_url : String
    
    //MARK: Hashable Functions
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
        hasher.combine(avatar_url)
    }
    
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.avatar_url == rhs.avatar_url
            && lhs.login == rhs.login
    }
    
    init(login: String, avatar_url: String) {
        self.login = login
        self.avatar_url = avatar_url
    }
    
}
