//
//  UITabbarController+Ext.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 20/12/20.
//

import UIKit

let kAnimationDuration = 0.3

extension UITabBarController {
    
    func setTabbarHidden(hidden: Bool, animated: Bool) {
        let animationDuration = animated ? kAnimationDuration : 0.0
        let tabbar = self.tabBar 

        let tabBarHeight  = tabbar.frame.height
        var tabBarOriginY = tabbar.frame.origin.y
        let viewOriginY   = self.view.frame.height

        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveLinear,.curveEaseIn]) { [self] in

            if tabBarOriginY == viewOriginY && hidden == false {
                tabBarOriginY -= tabBarHeight
            } else if tabBarOriginY < viewOriginY && hidden == true {
                tabBarOriginY += tabBarHeight
            }
            
            self.tabBar.frame.origin.y =   tabBarOriginY
        }
    }
}

