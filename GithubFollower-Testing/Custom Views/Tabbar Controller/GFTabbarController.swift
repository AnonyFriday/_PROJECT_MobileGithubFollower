//
//  GFTabbarController.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 2/12/20.
//

import UIKit

class GFTabbarController: UITabBarController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure
        self.tabBar.tintColor             = .systemGreen
        self.tabBar.layer.cornerRadius    = 30
        self.tabBar.clipsToBounds         = true
        
        // UITabBar.setTransparentTabbar()
        self.setViewControllers([createSearchNC(), createFarovitesNC()], animated: true)
    }
    
    
    //MARK: - SearchNC
    func createFarovitesNC() -> UINavigationController {
        let favoriteVC                  = FavoritesVC()
        favoriteVC.tabBarItem           = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        favoriteVC.tabBarItem.title = "Favorites"
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    
    //MARK: - FavoritesNC
    func createSearchNC() -> UINavigationController {
        let searchVC                    = SearchVC()
        searchVC.tabBarItem             = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchVC.tabBarItem.title   = "Search"
        return UINavigationController(rootViewController: searchVC)
    }
    
    
}
