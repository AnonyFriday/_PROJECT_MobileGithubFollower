//
//  GFItemFollowersVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import UIKit

class GFItemFollowersVC: GFItemSuperClassVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        itemViewOne.setType(type: .following, with: user.following)
        itemViewTwo.setType(type: .followers, with: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func didTappedActionButton() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(alertTitle: "No Followers", body: "This guy doesn't have any followers. What a shame 😢", buttonTitle: "Ok")
            return
        }
        
        delegate.itemInforVC(showFollowersOf: user)
        dismiss(animated: true)
    }
 
}
