//
//  EndpointManager.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 26/12/20.
//

import UIKit

struct EndpointManager {
    private var path: String?
    private var queryItems: [URLQueryItem]?
    
    var urlAvatarImage : URL?
    var urlGithub : URL? {
        var urlComponents        = URLComponents()
        urlComponents.scheme     = "https"
        urlComponents.host       = "api.github.com"
        urlComponents.path       = path ?? "/"
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    
}

extension EndpointManager {
    
    static func getFollowers(username: String, page: Int) -> Self {
        return EndpointManager(path: "/users/\(username)/followers",
                               queryItems: [
                                URLQueryItem(name: "per_page", value: "100"),
                                URLQueryItem(name: "page", value: "\(page)")
                               ])
    }
    
    
    static func getUser(username: String) -> Self {
        return EndpointManager(path: "/users/\(username)",
                               queryItems: nil)
    }
    
    
    static func getAvatarImage(avatarUrl: String) -> Self {
        let avatarUrl = URL(string: avatarUrl)
        return EndpointManager(path: nil,
                               queryItems: nil,
                               urlAvatarImage: avatarUrl)
    }
}
