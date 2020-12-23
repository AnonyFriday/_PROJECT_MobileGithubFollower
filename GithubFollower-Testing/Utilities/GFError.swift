//
//  GFError.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 19/10/20.
//

import Foundation

enum GFError: String, Error {
    case unableToComplete   = "Some thing wrong happend. Please try again 😢"
    case invalidUsername    = "There was something wrong at the server. Please try again"
    case invalidResponse    = "Unable to get the response back from the server. Please try again your network connection 😢"
    case invalidData        = "The data from the server was invalid. Please try again 😢"
    
    case unableGetFavorites     = "Unable to get the favorite list. Please try again 😢"
    case alreadyExistinFavorite = "You've already favorited this guy. You must love him so much 🤣"
    case unableSaveFavorite     = "Unable to save into the favorite List. Please try again 😢"
}
